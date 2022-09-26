#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

void *threadFun(void *vargs) {
  sleep(1);
  printf("Print from Thread\n");
  return NULL;
}

int main() {
  pthread_t thread_id;
  printf("Starting thread\n");
  pthread_create(&thread_id, NULL, threadFun, NULL);
  pthread_join(thread_id, NULL);
  printf("Thread DONE\n");
  exit(0);
}
