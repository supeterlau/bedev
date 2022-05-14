;; Ch3

1

"first string"

["first" "valid" "vector" "string"]

(str "Hello" "Emacs" "and" "Clojure")

;; if

(if true
  "Buy Zeus's hammer!"
  "Buy Aquaman's trident!")

(if false
  "Hidden Text")
;; => nil

;; do
(if true
  (do (println "Success!")
      "Buy coffee")
  (do (println "Failure!")
      "Buy tea"))

;; when
(when true
  (println "Fire")
  "usa")

(nil? nil)

(= nil nil)

(or false nil :usa :uk)

(and nil)

(def users
  ["superman" "batman" "joker"])

;; bad way
;; 重复绑定同一个 name

(def severity :mild)
(def error-message "OH GOD!")
(if (= severity :mild) 
  (def error-message 
    (str error-message "MILD"))
  (def error-message 
    (str error-message "DOOMED")))

(println error-message)

;; clojure way

(defn error-message
  [severity]
  (str "OH GOD!"
    (if (= severity :mild)
      "MILD"
      "DOOMED")))

(println (error-message :mild))

;; Numbers

3
4.2
1/3

;; Strings

(def name "Musk")
(println (str "\"Find U!\" \n" name))

;; Maps

{}

{:first-name "Elon"
 :last-name "Musk"}

{"str-add" +}

{:name {:f "Elon" :m "Great" :l "Musk"}}

(def elon
  {:name {:f "Elon" :m "Great" :l "Musk"}})

(hash-map :sun "sun" :moon "moon")

(get elon :name)

(get elon :sky)

(get elon :sky "SKY")

(get-in elon [:name :f])

(elon :name)

;; Keywords

(:name elon)

(:sky elon "Hahaha")

;; Vectors

[1/3 4.5 "Yo"]

(get [{:name "Elon"} :cool 4000] 1)

(get [{:name "Elon"} :cool 4000] 3)
(get [{:name "Elon"} :cool 4000] -1)

(vector "Kotlin" "Scala" "JRuby")

(conj [1 1.1 1.2] 1.3)

;; Lists

(def e-list
  '(1 :a "Clojure"))

(nth e-list 0)

;; (nth e-list -1000)

;; (nth e-list 1000)

(list "we" :like "OP")

(conj e-list :bye)

;; Sets

#{"Cat" :Dog 2049}

(hash-set 1 2 1 2 1 2)

(conj #{:x :y :z} :z)

(set '("set" :from "list"))

(def e-set #{:x :y :z})

(contains? e-set :z)

(contains? e-set :o)

(:o e-set)

(:z e-set)

(get e-set :o)

(get e-set nil)  ; => nil

(get #{nil} nil) ; => nil

(contains? #{nil} nil) ; => true

;;; Function

;; Call function

((or + -) 1 3 3 4)

(inc 1.1)

(map inc [1.1 2.2 3.3])

(+ (inc 199) (/ 100 (- 7 2)))

;; Function Callls, Macro Calls, Special Forms

[1 2 3 4]
'[13 13 13]
#{1 2 3}
{:key1 "v1"}

(if true
  "Branch1"
  "Branch2")

;; Defining Functions

(defn first-fn
  "Return cheer"
  [name]
  (str "Hello " name))

(first-fn "Clojure")

(defn no-params
  []
  "no parameters!")

(defn one-param
  [x]
  (str "one parameter: " x))

(defn two-params
  [x y]
  (str "two parameters: " x y))

(defn multi-arity
  ([fa sa ta]
   (str fa sa ta))
  ([fa sa]
   (str fa sa))
  ([fa]
   (str fa)))

;; default parameter

(defn x-chop
  "show chop"
  ([name chop-type]
    (str "chop type: " chop-type " name: " name))
  ([name]
    (x-chop name "karate")))

;; rest parameters

(defn codger-str
  [whip]
  (str "Gocha, " whip " !!!"))

(defn codger
  [& whips]
  (map codger-str whips))

(codger "ch1" "ch2" "ch3")

(defn custom-hd
  [[elem]]
  elem)

(custom-hd ["us" "usa" "uk"])

(custom-hd '["us" "usa" "uk"])

(defn submit-loc
  [{lat :lat lng :lng}]
  ;; [{:keys [lat lng]}]
  ;; [{:keys [lat lng] :as loc}]
  (println (str "Lat: " lat))
  (println (str "Lng: " lng)))

(submit-loc {:lat 22.00 :lng 23.00})

;; function body
;; 可以有多个 form 

(defn try-fbody
  []
  (+ 1 100)
  30
  "joe") 

(try-fbody)

;; 匿名函数形式 1
(map (fn [name] (str "Up, " name))
  ["Dan" "Joe" "Bill"])

;; 匿名函数形式 2
(#(* % 3) 8)

(def add3 #(+ % 3))

(add3 3)

;; function as return value 

(defn inc-maker
  "custom incrementor"
  [inc-by]
  #(+ % inc-by))

(def inc3 (inc-maker 3))

(inc3 117)

;; All Toether 

(def asym-hobbit-body-parts [
  {:name "head" :size 3}
  {:name "left-eye" :size 1}
  {:name "left-ear" :size 1}
  {:name "mouth" :size 1}
  {:name "nose" :size 1}
  {:name "neck" :size 2}
  {:name "left-shoulder" :size 3}
  {:name "left-upper-arm" :size 3}
  {:name "chest" :size 10}
  {:name "back" :size 10}
  {:name "left-forearm" :size 3}
  {:name "abdomen" :size 6}
  {:name "left-kidney" :size 1}
  {:name "left-hand" :size 2}
  {:name "left-knee" :size 2}
  {:name "left-thigh" :size 4}
  {:name "left-lower-leg" :size 3}
  {:name "left-achilles" :size 1}
  {:name "left-foot" :size 2}
])

(defn matching-part
  [part]
  {:name (clojure.string/replace (:name part) #"^left-" "right-")
   :size (:size part)})

(defn symmetrize-body-parts
  "Expects a seq of maps that have a :name and :size"
  [asym-body-parts]
  (loop [remaining-asym-parts asym-body-parts final-body-parts []]
    (if (empty? remaining-asym-parts)
      final-body-parts
      (let [[part & remaining] remaining-asym-parts]
        (recur remaining
          (into final-body-parts
            (set [part (matching-part part)])))))))

(symmetrize-body-parts asym-hobbit-body-parts)

(def x 0)
(let [x 1] x)
(println x)

(def avector ["Maybe" "#$%@#"])
(let [[x y] avector]
  (str x " >+< " y))

(into avector #{"v1" "v2"})

(into [] (set [:a :a]))

;; loop 

(loop [iteration 0]
  (println (str "Iter " iteration))
  (if (> iteration 3)
    (println "Bye")
    (recur (inc iteration))))

;; normal recurision

(defn recursive-printer
  ([]
    (recursive-printer 0))
  ([iteration]
    (println iteration)
    (if (> iteration 3)
      (println "bye")
      (recursive-printer (inc iteration)))))

(recursive-printer)

(re-find #"^ *;" "  ;") ; "  ;"

(re-find #"^ *;" "  x;") ; nil

(matching-part {:name "left-rocket" :size 100})

(reduce + [1 2 3 5])

(defn fake-reduce
  "f: function coll: collection"
  ([f initial coll]
   ;; loop 两个初始值
   (loop [result initial
          remaining coll]
     (if (empty? remaining)
       result
       ;; (recur a b) 对应 loop 中两个参数
       (recur (f result (first remaining)) (rest remaining)))))
  ([f [head & tail]]
    (fake-reduce f head tail)))

(fake-reduce + [23 24 25])

;; reimplement symmetrizer

(defn better-symmetrize-body-parts
  [asym-body-pairs]
  (reduce (fn [final-body-parts part]
            (into final-body-parts (set [part (matching-part part)])))
          []
          asym-body-pairs))

(better-symmetrize-body-parts asym-hobbit-body-parts)

(let [a 1 b 2 c 3]
  (println a)
  (println b)
  (println c))

(defn hit
  [asym-body-parts]
  (let [sym-parts (better-symmetrize-body-parts asym-body-parts) 
        body-part-size-sum (reduce + (map :size sym-parts))
        target (rand body-part-size-sum)]
     (loop [[part & remaining] sym-parts
            accumulated-size (:size part)]
       (if (> accumulated-size target)
         part
         (recur remaining (+ accumulated-size (:size (first remaining))))))))

(hit asym-hobbit-body-parts)
