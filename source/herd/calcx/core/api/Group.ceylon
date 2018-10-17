

shared abstract class Group(shared Boolean opening) of open|close {
}
shared object open extends Group(true){}
shared object close extends Group(false) {}
