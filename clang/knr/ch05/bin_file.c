#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LEN 50
#define N_STUD 3

typedef struct stud{
	char name[LEN+1];
	unsigned int id;
	float average;
} stud_t;

int main()
{
	FILE *fp;
	stud_t student[N_STUD];
	char row[LEN+1];
	unsigned int n_stud;

	int i;

	strcpy(student[0].name, "Steve");
	student[0].id = 101;
	student[0].average = 25.5;

	strcpy(student[1].name, "Fred");
	student[1].id = 102;
	student[1].average = 55.5;

	strcpy(student[2].name, "Floyd");
	student[2].id = 103;
	student[2].average = 33.3;

	fp = fopen("stud.bin", "wb");
	if (fp == NULL) {
		printf("Error: file stud.bin cannot be opened\n");
		exit(1);
	}

	fwrite(student, sizeof(stud_t), N_STUD, fp);
	fclose(fp);

	fp = fopen("stud.bin", "rb");
	if (fp == NULL) {
		printf("Error: file stud.bin cannot be opened\n");
		exit(1);
	}

	n_stud = 0;
	while(fread(&student[n_stud], sizeof(stud_t), 1, fp) == 1) {
		n_stud++;
	}
	fclose(fp);

	// print students
	for(i=0;i<n_stud;i++) {
		stud_t s = student[i];
		printf("%s %d %f\n", s.name, s.id, s.average);
	}
}
