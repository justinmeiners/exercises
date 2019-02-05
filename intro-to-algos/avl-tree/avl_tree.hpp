// Created By: Justin Meiners (2017)

#include <iostream>
#include <algorithm>
#include <sstream>
#include <stack>

template <typename T>
class AvlTree
{
public:
    AvlTree();
  
    void insert(const T& data);
  
    template <typename F>
    void traverseInOrder(F func);
 
    template <typename F>
    void traversePreOrder(F func); 

private:
    struct Node
    {
        // Node height defaults to 1
        Node(const T& data);

        T data;

        Node* left;
        Node* right;

        int height;
        int calcBalance();
        int calcHeight();
    };

    // recursive overload
    template <typename F>
    void traverseInOrder(Node* node, F func);

    // recursive overload
    Node* insert(Node* current, const T& data);
    // rotates a node left
    Node* rotateLeft(Node* node);
    // rotates a node right
    Node* rotateRight(Node* node);

    Node* root;
};

template <typename T>
AvlTree<T>::Node::Node(const T& data)
    : data(data), left(nullptr), right(nullptr), height(1) {}

template <typename T>
int AvlTree<T>::Node::calcHeight()
{
    int leftHeight = left ? left->height : 0;
    int rightHeight = right ? right->height : 0;

    return 1 + std::max(leftHeight, rightHeight); 
}

template <typename T>
int AvlTree<T>::Node::calcBalance()
{
    int leftHeight = left ? left->height : 0;
    int rightHeight = right ? right->height : 0;

    return leftHeight - rightHeight;
}

template <typename T>
AvlTree<T>::AvlTree() 
    : root(nullptr) {}

template <typename T>
void AvlTree<T>::insert(const T& data)
{
    root = insert(root, data);
}

template <typename T>
typename AvlTree<T>::Node* AvlTree<T>::insert(Node* current, const T& data)
{
    if (!current)
    {
        return new Node(data);   
    }
    
    if (data < current->data)
    {
        current->left = insert(current->left, data);
    }
    else if (data > current->data)
    {
        current->right = insert(current->right, data);
    }
    else
    {
        std::cout << "duplicate" << std::endl;
        return current;
    }

    current->height = current->calcHeight();
    int balance = current->calcBalance();
 
    if (balance < -1)
    {
        if (current->right->calcBalance() < 0)
        {
            // RR case
            //std::cout << "RR" << std::endl;
            current = rotateLeft(current);
        }
        else
        {
            // RL Case
            //std::cout << "RL" << std::endl;
            current->right = rotateRight(current->right);
            current = rotateLeft(current);
        }
    } 
    else if (balance > 1)
    { 
        if (current->left->calcBalance() > 0)
        {
            // LL case
            //std::cout << "LL" << std::endl;
            current = rotateRight(current);
        }
        else
        {
            // LR Case
            //std::cout << "LR" << std::endl;
            current->left = rotateLeft(current->left);
            current = rotateRight(current);
        }
    }
    
    return current;
}

template <typename T>
typename AvlTree<T>::Node* AvlTree<T>::rotateLeft(Node* node)
{
    // make the right child the new root
    Node* newRoot = node->right;
    // make the old root's right child the new root's left child
    node->right = newRoot->left;
    // make the old root the new root's left  
    newRoot->left = node;

    // update heights
    node->height = node->calcHeight();
    newRoot->height = newRoot->calcHeight();

    return newRoot; 
}

template <typename T>
typename AvlTree<T>::Node* AvlTree<T>::rotateRight(Node* node)
{
    // make the left child the new root
    Node* newRoot = node->left;
    // make the old root's left child the new root's right child
    node->left = newRoot->right;
    // make the old root the new root's right
    newRoot->right = node;

    // update heights
    node->height = node->calcHeight();
    newRoot->height = newRoot->calcHeight();

    return newRoot;
}

template <typename T>
template <typename F>
void AvlTree<T>::traverseInOrder(Node* node, F func)
{
    if (!node)
        return;

    traverseInOrder(node->left, func);
    func(node->data);
    traverseInOrder(node->right, func);
}

template <typename T>
template <typename F>
void AvlTree<T>::traverseInOrder(F func)
{
    traverseInOrder(root, func);
}

template <typename T>
template <typename F>
void AvlTree<T>::traversePreOrder(F func)
{
    if (!root)
        return;

    std::stack<Node*> stack;
    stack.push(root);

    while (!stack.empty())
    {
        Node* current = stack.top();
        func(current->data);
        stack.pop();

        if (current->right)
            stack.push(current->right);

        if (current->left)
            stack.push(current->left);
    }
}

