//
//  main.c
//  操作系统
//
//  Created by chenglin on 2024/5/29.
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <time.h>

#define MAX_QUEUE_SIZE 100

typedef enum { READY, WAITING, RUNNING, TERMINATED } ProcessState;

typedef struct {
    int pid;
    char name[20];
    int priority;
    int burst_time;
    int remaining_time;
    ProcessState state;
    int waiting_event;
} PCB;

typedef struct {
    PCB *processes[MAX_QUEUE_SIZE];
    int front;
    int rear;
    int size;
} Queue;

typedef struct {
    int value;
    Queue waiting_queue;
} Semaphore;

Queue ready_queue = {.front = 0, .rear = -1, .size = 0};
Queue waiting_queue = {.front = 0, .rear = -1, .size = 0};
Semaphore resource_sem = {.value = 1, .waiting_queue = {.front = 0, .rear = -1, .size = 0}};
PCB *current_process = NULL;

typedef enum { FCFS, SJF, PRIORITY } SchedulingAlgorithm;
SchedulingAlgorithm current_algorithm = FCFS;

void enqueue(Queue *queue, PCB *process) {
    if (queue->size == MAX_QUEUE_SIZE) return;
    queue->rear = (queue->rear + 1) % MAX_QUEUE_SIZE;
    queue->processes[queue->rear] = process;
    queue->size++;
}

PCB* dequeue(Queue *queue) {
    if (queue->size == 0) return NULL;
    PCB *process = queue->processes[queue->front];
    queue->front = (queue->front + 1) % MAX_QUEUE_SIZE;
    queue->size--;
    return process;
}

void dequeue_at(Queue *queue, int index) {
    if (queue->size == 0 || index >= queue->size) return;
    for (int i = index; i < queue->size - 1; i++) {
        queue->processes[i] = queue->processes[(queue->front + i + 1) % MAX_QUEUE_SIZE];
    }
    queue->rear = (queue->rear - 1 + MAX_QUEUE_SIZE) % MAX_QUEUE_SIZE;
    queue->size--;
}

void create_process(int pid, char* name, int priority, int burst_time) {
    if (burst_time <= 0) {
        printf("Invalid burst time for process %d.\n", pid);
        return;
    }
    PCB *new_process = (PCB *)malloc(sizeof(PCB));
    new_process->pid = pid;
    strcpy(new_process->name, name);
    new_process->priority = priority;
    new_process->burst_time = burst_time;
    new_process->remaining_time = burst_time;
    new_process->state = READY;
    enqueue(&ready_queue, new_process);
}

PCB* schedule_FCFS(Queue *ready_queue) {
    return dequeue(ready_queue);
}

PCB* schedule_SJF(Queue *ready_queue) {
    if (ready_queue->size == 0) return NULL;
    int min_index = 0;
    for (int i = 1; i < ready_queue->size; i++) {
        if (ready_queue->processes[(ready_queue->front + i) % MAX_QUEUE_SIZE]->remaining_time < ready_queue->processes[(ready_queue->front + min_index) % MAX_QUEUE_SIZE]->remaining_time) {
            min_index = i;
        }
    }
    PCB *selected = ready_queue->processes[(ready_queue->front + min_index) % MAX_QUEUE_SIZE];
    dequeue_at(ready_queue, min_index);
    return selected;
}

PCB* schedule_priority(Queue *ready_queue) {
    if (ready_queue->size == 0) return NULL;
    int max_index = 0;
    for (int i = 1; i < ready_queue->size; i++) {
        if (ready_queue->processes[(ready_queue->front + i) % MAX_QUEUE_SIZE]->priority > ready_queue->processes[(ready_queue->front + max_index) % MAX_QUEUE_SIZE]->priority) {
            max_index = i;
        }
    }
    PCB *selected = ready_queue->processes[(ready_queue->front + max_index) % MAX_QUEUE_SIZE];
    dequeue_at(ready_queue, max_index);
    return selected;
}

void schedule_next_process() {
    if (ready_queue.size == 0) {
        current_process = NULL;
        printf("No processes in the ready queue.\n");
        return;
    }
    switch (current_algorithm) {
        case FCFS:
            current_process = schedule_FCFS(&ready_queue);
            break;
        case SJF:
            current_process = schedule_SJF(&ready_queue);
            break;
        case PRIORITY:
            current_process = schedule_priority(&ready_queue);
            break;
        default:
            current_process = NULL;
    }
    if (current_process != NULL) {
        printf("Scheduled process %d (%s) with priority %d and remaining time %d.\n",
               current_process->pid, current_process->name,
               current_process->priority, current_process->remaining_time);
    }
}

void execute_process(PCB *process) {
    while (process->remaining_time > 0) {
        if (resource_sem.value <= 0) {
            enqueue(&resource_sem.waiting_queue, process);
            process->state = WAITING;
            printf("Process %d is waiting for the resource.\n", process->pid);
            schedule_next_process();
            return;
        }
        resource_sem.value--;
        process->remaining_time--;
        printf("Executing process %d (%s). Remaining time: %d\n", process->pid, process->name, process->remaining_time);
        resource_sem.value++;
    }
    process->state = TERMINATED;
    printf("Process %d (%s) has terminated.\n", process->pid, process->name);
    free(process);
    schedule_next_process();
}

void wait_semaphore(Semaphore *sem) {
    sem->value--;
    if (sem->value < 0) {
        enqueue(&sem->waiting_queue, current_process);
        current_process->state = WAITING;
        schedule_next_process();
    }
}

void signal_semaphore(Semaphore *sem) {
    sem->value++;
    if (sem->value <= 0) {
        PCB *process = dequeue(&sem->waiting_queue);
        process->state = READY;
        enqueue(&ready_queue, process);
    }
}

void test_create_process() {
    create_process(1, "Process1", 5, 10);
    assert(ready_queue.size == 1);
    assert(ready_queue.processes[ready_queue.front]->pid == 1);
    printf("Test create_process passed.\n");
}

void test_integrated_system() {
    create_process(1, "Process1", 5, 10);
    create_process(2, "Process2", 3, 5);
    current_algorithm = FCFS;
    schedule_next_process();
    assert(current_process->pid == 1);
    execute_process(current_process);
    schedule_next_process();
    assert(current_process->pid == 2);
    execute_process(current_process);
    printf("Test integrated_system passed.\n");
}

void test_performance(void) {
    for (int i = 0; i < 1000; i++) {
        create_process(i, "Process", 1, 1);
    }
    clock_t start = clock();
    while (ready_queue.size > 0) {
        schedule_next_process();
        execute_process(current_process);
    }
    clock_t end = clock();
    printf("Execution time for 1000 processes: %f seconds\n", (double)(end - start) / CLOCKS_PER_SEC);
}

void test_error_handling() {
    create_process(1, "Process1", 5, -1);  // Invalid burst time
    assert(ready_queue.size == 0);  // Process should not be added
    printf("Test error_handling passed.\n");
}

int main(void) {
    test_create_process();
    test_integrated_system();
    test_performance();
    test_error_handling();
    return 0;
}

