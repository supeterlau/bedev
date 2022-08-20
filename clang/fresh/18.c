#include <stdio.h>
#include <string.h>

struct student
{
  int id;
  char name[20];
  float percentage;
};

void print_record(struct student record);
void print_recordptr(struct student *record);

// 定义 Global struct
// struct student global_student;

int main()
{
  struct student record1 = {0};

  record1.id = 1;
  strcpy(record1.name, "Lei");
  record1.percentage = 89;

  printf("Id : %d \n", record1.id);
  printf("Name : %s \n", record1.name);
  printf("Percentage : %f \n", record1.percentage);

  // pass structure to function

  print_record(record1);

  print_recordptr(&record1);

  // array of structure
  
  printf("\n*** Array of Structures \n***\n");
  int i;

  struct student records[3];

  struct student record2 = {2, "Elixir_NEW", 81.0};
  records[0] = record2;

  // records[0].id = 2;
  // strcpy(records[0].name, "Elixir");
  // records[0].percentage = 81.0;

  records[1].id = 3;
  strcpy(records[1].name, "Erlang");
  records[1].percentage = 83.0;

  records[2].id = 4;
  strcpy(records[2].name, "Rust");
  records[2].percentage = 88.0;

  for(i=0;i<3;i++)
  {
    print_record(records[i]);
  }

  return 0;
}

void print_record(struct student record)
{
  printf("***\nin print_record\n***\n");
  printf("Id : %d \n", record.id);
  printf("Name : %s \n", record.name);
  printf("Percentage : %f \n", record.percentage);
}

void print_recordptr(struct student *record)
{
  printf("***\nin print_recordptr\n***\n");
  printf("Id : %d \n", record->id);
  printf("Name : %s \n", record->name);
  printf("Percentage : %f \n", record->percentage);
}
