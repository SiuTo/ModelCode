#include <iostream>

using namespace std;

class Node {
    public:
        int x;
        string s;

        Node() : x(0), s("") {}

        Node(int x0, string s0) : x(x0), s(s0) {}
};

template<class T>
class Smart_ptr;

template<class T>
class Pointer {
    friend class Smart_ptr<T>;

    private:
        int count;
        T* ptr;

        Pointer() : count(0), ptr(nullptr) {}

        Pointer(T *p) : count(1), ptr(p) {}

        ~Pointer() {
            delete ptr;
        }
};

template<class T>
class Smart_ptr {
    private:
        Pointer<T> *sptr;

    public:
        Smart_ptr() : sptr(nullptr) {}

        Smart_ptr(T *p) : sptr(new Pointer<T>(p)) {}

        Smart_ptr(const Smart_ptr &new_sptr) : sptr(new_sptr.sptr) {
            ++sptr->count;
        }

        Smart_ptr & operator=(const Smart_ptr &new_sptr) {
            if (--sptr->count == 0)
                delete sptr;
            sptr = new_sptr->ptr;
            ++sptr->count;
            return *this;
        }

        T operator*() {
            return *(sptr->ptr);
        }

        T* operator->() {
            return sptr->ptr;
        }

        T* get() {
            return sptr->ptr;
        }

        ~Smart_ptr() {
            cout << "Count is " << sptr->count << endl;
            if (--sptr->count == 0)
                delete sptr;
        }
};

int main() {
    Node *p = new Node(1, "abc");
    {
        Smart_ptr<Node> ptr1(p);
        {
            Smart_ptr<Node> ptr2(ptr1);
            {
                Smart_ptr<Node> ptr3 = ptr2;

                cout << (*ptr1).x << endl;
                ptr1->x = 2;
                cout << ptr2->x << endl;
            }
        }
    }
    cout << p->x << endl;
    return 0;
}

