(if true
  "Cat"
  "Dog")

(or false nil :why_not)

(defn greet [name] (str "Welcome " name))

(greet "Nice")

(defn error-message
  [severity]
  (str "OH GOD! "
       (if (= severity :mild)
         "MILDLY"
         "DOOOOMED")))
(error-message :mild)

({:token "a-very-long-token"} :token)

(:hi {:hi "Have a good day"})
(:not_found {:hi "Have a good day"} "Oops")

(get [true nil 1/4 0.11 "What?"] 3)

(get [true nil 1/4 0.11 "What?"] -1)

(def bag [true nil 1/4 0.11 "What?"])

(conj [] 3/7)

(conj bag 9/8)

(println bag)

'("What?" :ok)

(conj '(:one "two" 3) {4 5})

(get {3 4} 3)

(hash-set 1 1 2 3 4 4)

(conj #{1 2 3} 3)

(set [3 3 3 4 4 5])

(set '(:ok :error :bad :ok))

(contains? #{:a :b} :c)

(:key #{:sunny :rainy})

(get #{:hi :dube} "Kurt" "FINE")

(first [:a :b])

(or + -)

(defn no-params
  []
  "NO parameters!")

(defn one-params
  [name]
  (str "one parameter: " name))

(defn two-params
  [name age]
  (str "two parameter: " name age))

(two-params "Bob" 40)


(defn buy
  [thing]
  (str "Good! Go to buy " thing))

(defn buy-things
  [& things]
  (map buy things))

(buy-things "Apple" "Orange" "Water")

(defn my-things
  [name & things]
  (str "Yeah! I like " (clojure.string/join ", " things)))

(my-things "Bob" "tea" "coffee" "juice")

;; my version first (first [1 2 3])
(defn my-first
  [[first-value]]
  first-value)

(my-first '(1 2 3))
(my-first [4 5 6])
(my-first #{1 2 3})

((fn [x] (* x 3)) 90)

(#(str %1 " and " %2) "Alice" "Bob")

(#(identity %&) 1 2 "Blur")

(defn inc-maker
  [inc-by]
  #(+ % inc-by))

(def inc3 (inc-maker 3))

(inc3 20)

(let [inc3 3000] inc3)

(let [x 3 y 4 z 5] (* x y z))

(into [] #{1})

(loop [iter 0]
  (println (str "Iteration " iter))
  (if (> iter 3)
    (println "Bye")
    (recur (inc iter))))

(defn my-recur
  ([]
	  (my-recur 0))
	([iter]
	  (println iter)
		(if (> iter 3)
		  (println "Bye!")
			(my-recur (inc iter)))))

(my-recur)

(re-find #"^left-" "left-eye")

(reduce + '(1 2 3 4))

(reduce + [1 2 3 4])

(reduce + 10 [1 2 3 4])

(empty? [])
(empty? {})
(empty? #{})
;; (empty? {{}})

(rest [1 2 3])
