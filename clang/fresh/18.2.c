#include <stdio.h>
#include <string.h>

struct student_college_detail
{
  int college_id;
  char college_name[50];
};

struct student_detail
{
  int id;
  char name[20];
  float percentage;
  struct student_college_detail clg_data;
} stu_data, *stu_data_ptr;

int main()
{
  // stu_data = {1, "Elixir", 80.1, 77777, "OTP University"};
  stu_data.id = 1;
  // stu_data.name = "Elixir";
  strcpy(stu_data.name, "Elixir");
  stu_data.percentage = 80.1;

  struct student_college_detail clg = {88888, "OTP University"};
  stu_data.clg_data = clg;

  // 初始化
  struct student_detail stu_data = {2, "Elixir_NEW", 18.0, 77777, "DOTA University"};
  stu_data_ptr = &stu_data;
  printf("  Id is: %d \n", stu_data_ptr->id);
  printf("  Name is: %s \n", stu_data_ptr->name);
  printf("  Percentage is: %f \n\n", stu_data_ptr->percentage);

  printf("  College Id is: %d \n", stu_data_ptr->clg_data.college_id);
  printf("  College Name is: %s \n", stu_data_ptr->clg_data.college_name);
}
