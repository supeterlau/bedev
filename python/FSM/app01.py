import random 

def fib():
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b

def grep(substr):
    while True:
        line = yield
        if substr in line:
            print(f"found {substr}")

# start coroutine
def prime(fn):
    def wrapper(*args, **kwargs):
        v = fn(*args, **kwargs)
        v.send(None)
        return v
    return wrapper

class RegexFSM:
    def __init__(self):
        self.start = self._create_start()
        self.q1 = self._create_q1()
        self.q2 = self._create_q2()
        self.q3 = self._create_q3()

        self.current_state = self.start
        self.stopped = False

    def send(self, char):
        try:
            self.current_state.send(char)
        except StopIteration:
            self.stopped = True

    def does_match(self):
        if self.stopped:
            return False 
        return self.current_state == self.q3

    @prime
    def _create_start(self):
        while True:
            char = yield 
            if char == 'a':
                self.current_state = self.q1
            else:
                break

    @prime
    def _create_q1(self):
        while True:
            char = yield
            if char == 'b':
                self.current_state = self.q2
            elif char == 'c':
                self.current_state = self.q3
            else:
                break

    @prime
    def _create_q2(self):
        # self._create_q1()
        while True:
            char = yield
            if char == 'b':
                self.current_state = self.q2
            elif char == 'c':
                self.current_state = self.q3
            else:
                break

    @prime
    def _create_q3(self):
        while True:
            char = yield
            break

class Divisibility3FSM:
    def __init__(self):
        self.init = self._create_init()
        # self.init.send(None)
        self.q0 = self._create_q0()
        # self.q0.send(None)
        self.q1 = self._create_q1()
        # self.q1.send(None)
        self.q2 = self._create_q2()
        # self.q2.send(None)

        self.current_state = self.init

    def send(self, digit):
        self.current_state.send(digit)

    def is_divisible(self):
        return self.current_state == self.q0

    @prime
    def _create_q0(self):
        while True:
            digit = yield 
            if digit in [0,3,6,9]:
                self.current_state = self.q0
            elif digit in [1,4,7]:
                self.current_state = self.q1
            elif digit in [2,5,8]:
                self.current_state = self.q2
    @prime
    def _create_q1(self):
        while True:
            digit = yield 
            if digit in [0,3,6,9]:
                self.current_state = self.q1
            elif digit in [1,4,7]:
                self.current_state = self.q2
            elif digit in [2,5,8]:
                self.current_state = self.q0
    @prime
    def _create_q2(self):
        while True:
            digit = yield 
            if digit in [0,3,6,9]:
                self.current_state = self.q2
            elif digit in [1,4,7]:
                self.current_state = self.q0
            elif digit in [2,5,8]:
                self.current_state = self.q1
    @prime
    def _create_init(self):
        while True:
            digit = yield 
            if digit in [0,3,6,9]:
                self.current_state = self.q0
            elif digit in [1,4,7]:
                self.current_state = self.q1
            elif digit in [2,5,8]:
                self.current_state = self.q2

class SQLValidatorFSM:
    def __init__(self):
        self.init = self._create_init()
        self.select_stmt = self._create_select_stmt()
        self.all_cols = self._create_all_cols()
        self.explicit_cols = self._create_explicit_cols()
        self.from_clause = self._create_from_clause()
        self.more_cols = self._create_more_cols()
        self.tablename = self._create_tablename()
        self.valid_sql = self._create_valid_sql()

        self.current_state = self.init 
        self.stopped = False

    def send(self, token):
        try:
            self.current_state.send(token)
        except StopIteration:
            self.stopped = True

    def is_valid(self):
        if self.stopped:
            return False 
        return self.current_state == self.valid_sql

    @prime
    def _create_init(self):
        while True:
            token = yield
            if token == 'select':
                self.current_state = self.select_stmt
            else:
                break

    @prime
    def _create_select_stmt(self):
        while True:
            token = yield
            if token == "*":
                self.current_state = self.all_cols
            else:
                self.current_state = self.explicit_cols
    @prime
    def _create_all_cols(self):
        while True:
            token = yield 
            if token == 'from':
                self.current_state = self.from_clause
            else:
                break

    @prime
    def _create_explicit_cols(self):
        while True:
            token = yield
            if token == 'from':
                self.current_state = self.from_clause
            elif token == ',':
                self.current_state = self.more_cols
            else:
                break

    @prime
    def _create_from_clause(self):
        while True:
            token = yield
            if token.isalnum():
                self.current_state = self.tablename 
            else:
                break

    @prime
    def _create_more_cols(self):
        while True:
            token = yield 
            if token.isalnum():
                self.current_state = self.explicit_cols 
            else:
                break

    @prime
    def _create_tablename(self):
        while True:
            token = yield 
            if token == ";":
                self.current_state = self.valid_sql 
            else:
                break

    @prime
    def _create_valid_sql(self):
        while True:
            token = yield 
            if token == ";":
                self.current_state = self.valid_sql 
            else:
                break

# Run

def grep_regex(text): 
    evaluator = RegexFSM()
    for ch in text:
        evaluator.send(ch)
    return evaluator.does_match()

def divisible_by_3():
    number = ''
    evaluator = Divisibility3FSM()
    for i in range(20):
        digit = random.randint(0, 9)
        number += str(digit)
        evaluator.send(digit)
        print(number, evaluator.is_divisible())

# divisible_by_3()

def validate_sql(query):
    validator = SQLValidatorFSM()
    for token in query.split():
        validator.send(token)
    return validator.is_valid()

# validate_sql('select * from users ;')
