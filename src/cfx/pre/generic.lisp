;;;; ./src/cfx/pre/generic.lisp

(in-package :mnas-ansys/cfx/pre)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; generic

(defgeneric add (item  collection)
  (:documentation
   "Добавляем объект @b(item) в коллекцию @b(collection)."))

(defgeneric mesh (key container)
  (:documentation
   "Возвращает объект типа <mesh> по ключу @b(key) в контейнере @b(container)."))

(defgeneric mesh-names (container)
  (:documentation
   "@b(Описание:) метод @b(mesh-names) возвращает список имен сеток для
контейнера @b(container)."))

(defgeneric command (number container)
  (:documentation
   "@b(Описание:) метод @b(command) возвращает команду по ее номеру для
контейнера @b(container)."))

(defgeneric 2d-region (key obj)
  (:documentation
   "Возвращает имя 2d-региона по ключу имя Icem."))

(defgeneric 2d-region-values (obj)
  (:documentation
   "Возвращает список имен 2d-регионов объекта @b(obj)."))

(defgeneric 2d-region-keys (obj)
  (:documentation
   "Возвращает список имен 2d-регионов объекта @b(obj)."))

(defgeneric 3d-regions (obj)
  (:documentation
   "Возвращает список имен 3d-регионов объекта @b(obj)."))

(defgeneric 3d-region (key container)
  (:documentation
   "Возвращает объект класса <3d-region> по ключу @b(key) в контейнере @b(container)."))

(defgeneric 3d-region-mesh (mesh-name obj)
  (:documentation "Возвращает список объектов типа @b(<3d-region>) по имени сетки
@b(mesh-name) для объекта @b(obj)."))

(defgeneric 3d-region-min (mesh-name obj)
  (:documentation "Возвращает объект типа @b(<3d-region>) с минимальным 3d-суффиксом по
имени сетки @b(mesh-name) для объекта @b(obj)"))

(defgeneric 3d-region-not-min (mesh-name obj)
  (:documentation
   "@b(Описание:) Возвращает объекты типа @b(<3d-region>) с не минимальным
3d-суффиксом по имени сетки @b(mesh-name) из симуляции @b(obj)."))

(defgeneric 3d-region-max (mesh-name obj)
  (:documentation "Возвращает объект типа @b(<3d-region>) с минимальным 3d-суффиксом по
имени сетки @b(mesh-name) для объекта @b(obj)"))

(defgeneric 3d-region-not-max (mesh-name obj)
    (:documentation
  "@b(Описание:) Возвращает объекты типа @b(<3d-region>) с не
максимальным 3d-суффиксом по имени сетки @b(mesh-name) из симуляции @b(obj)."))

(defgeneric 3d-region-left (mesh-name obj)
  (:documentation "Возвращает список объектов типа @b(<3d-region>) с минимальными
3d-суффиксом по имени сетки @b(mesh-name) из симуляции @b(obj)."))

(defgeneric 3d-region-right (mesh-name obj)
  (:documentation "Возвращает список объектов типа @b(<3d-region>) с максимальными
3d-суффиксом по имени сетки @b(mesh-name) из симуляции @b(obj)."))
 
(defgeneric create-script (obj stream)
    (:documentation "Выводит в поток @b(stream) сценарий для вставки в командную строку
CFX."))

(defgeneric reset (obj)
  (:documentation
   "@b(Описание:) метод @b(reset) сбрасывает объект в исходное состояние и
возвращает его."))

(defgeneric interfaces-general (obj)
  (:documentation
   "@b(Описание:) метод @b(interfaces-general) возвращает список общих интерфейсов
объекта @b(obj)."))

(defgeneric locations (location)
  (:documentation
   "@b(Описание:) метод @b(locations) возвращает строку из местоположений объекта."))

(defgeneric name (obj)
  (:documentation
   "@b(Описание:) метод @b(name) возвращает имя объекта @b(obj)."))

(defgeneric name-old (obj)
  (:documentation
   "@b(Описание:) метод @b(name-old) возвращает старое имя объекта @b(obj)."))

(defgeneric do-add (3d-region simulation)
  (:documentation
   "@b(Описание:) метод @b(do-add) выполняет импорт и переименование 3d-региона
@b(3d-region) в симуляции @b(simulation)."))

(defgeneric interfaces (obj)
  (:documentation
   "@b(Описание:) метод @b(interfaces) возвращает список имен 2d-регионов,
являющихся интерфейсами для объекта @b(obj)."))

(defgeneric interfaces-with (3d-region mesh-name-2)
  (:documentation
   "@b(Описание:) метод @b(interfaces-with) возвращает список имен 2d-регионов
@b(3d-region), сопряженных с сеткой @b(mesh-name-2)."))

(defgeneric interface-rot-min (mesh-name simulation)
  (:documentation
   "Возвращает минимальные вращательные интерфейсы для сетки @b(mesh-name)."))

(defgeneric interface-rot-max (mesh-name simulation)
  (:documentation
   "Возвращает максимальные вращательные интерфейсы для сетки @b(mesh-name)."))

(defgeneric mk-rot-per-interfaces-n-m (mesh-name simulation &key postfix)
  (:documentation
   "Создает интерфейс вращательной периодичности для сетки @b(mesh-name)."))

(defgeneric interface-rot-left (mesh-name simulation)
  (:documentation
   "Возвращает левые интерфейсы вращательного типа для сетки @b(mesh-name)."))

(defgeneric interface-rot-right (mesh-name simulation)
  (:documentation
   "Возвращает правые интерфейсы вращательного типа для сетки @b(mesh-name)."))

(defgeneric mk-rot-gen-interfaces-n-m (mesh-name simulation &key postfix)
  (:documentation
   "Создает обобщенный вращательный интерфейс для сетки @b(mesh-name)."))

(defgeneric fluid-2d-regions (s-body-name simulation)
  (:documentation
   "Возвращает список флюидовых 2d-регионов по имени солидового тела @b(s-body-name)."))

(defgeneric solid-2d-regions (s-body-name simulation)
  (:documentation
   "Возвращает список солидовых 2d-регионов по имени солидового тела @b(s-body-name)."))

(defgeneric mk-f-s-interface-n-m (fluid-domain-name solid-domain-name simulation)
  (:documentation
   "Создает интерфейс типа флюид-солид между доменами."))

(defgeneric interface-pairs (obj)
  (:documentation
   "@b(Описание:) метод @b(interface-pairs) возвращает список пар имен сеток
для создания интерфейсов."))

(defgeneric interface-pairs-fluid (obj)
  (:documentation
   "@b(Описание:) метод @b(interface-pairs-fluid) возвращает список пар флюидовых
сеток для создания интерфейсов."))

(defgeneric interface-pairs-solid (obj)
  (:documentation
   "@b(Описание:) метод @b(interface-pairs-solid) возвращает список пар солидовых
сеток для создания интерфейсов."))

(defgeneric interface-pairs-fluid-general (obj)
  (:documentation
   "@b(Описание:) метод @b(interface-pairs-fluid-general) возвращает список пар
флюидовых сеток для создания обобщенных интерфейсов."))

(defgeneric interface-pairs-fluid-rotational (obj)
  (:documentation
   "@b(Описание:) метод @b(interface-pairs-fluid-rotational) возвращает список имен
флюидовых сеток для создания вращательных интерфейсов."))

(defgeneric domain-names-fluid (obj)
  (:documentation
   "@b(Описание:) метод @b(domain-names-fluid) возвращает имя флюидового домена
для объекта @b(obj)."))

(defgeneric domain-names-solid (obj)
  (:documentation
   "@b(Описание:) метод @b(domain-names-solid) возвращает список имен солидовых
доменов для объекта @b(obj)."))

(defgeneric select-3d-regions-by-mesh-name (mesh-name container)
  (:documentation
   "@b(Описание:) метод @b(select-3d-regions-by-mesh-name) возвращает список
3d-регионов по имени сетки @b(mesh-name) в контейнере @b(container)."))

(defgeneric select-3d-regions-name-by-mesh-name (mesh-name container)
  (:documentation
   "@b(Описание:) метод @b(select-3d-regions-name-by-mesh-name) возвращает список
имен 3d-регионов по имени сетки @b(mesh-name) в контейнере @b(container)."))

(defgeneric select-3d-regions-fluid (container)
  (:documentation
   "@b(Описание:) метод @b(select-3d-regions-fluid) возвращает список флюидовых
3d-регионов контейнера @b(container)."))

(defgeneric select-3d-regions-solid (container)
  (:documentation
   "@b(Описание:) метод @b(select-3d-regions-solid) возвращает список солидовых
3d-регионов контейнера @b(container)."))

(defgeneric simulation-fluid-domain-location (simulation)
  (:documentation
   "@b(Описание:) метод @b(simulation-fluid-domain-location) возвращает строку
списка 3d-регионов флюидового домена для симуляции @b(simulation)."))

(defgeneric simulation-solid-domain-mesh-location (mesh-name simulation)
  (:documentation
   "@b(Описание:) метод @b(simulation-solid-domain-mesh-location) возвращает строку
списка 3d-регионов солидового домена с именем @b(mesh-name) для симуляции @b(simulation)."))

(defgeneric select-2d-region-keys (regexp obj)
  (:documentation
   "@b(Описание:) метод @b(select-2d-region-keys) возвращает список ключей
2d-регионов, соответствующих регулярному выражению @b(regexp)."))

(defgeneric select-2d-region-values (regexp obj)
  (:documentation
   "@b(Описание:) метод @b(select-2d-region-values) возвращает список значений
2d-регионов, соответствующих регулярному выражению @b(regexp)."))
