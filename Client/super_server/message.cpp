#include "message.h"

void Message::addFile(MyFile file)
{
    files.append(file);
}

bool Message::operator<(const Message &d1) const
{

    return this->time<d1.time;
}

bool Message::operator>(const Message &d1) const
{
    return this->time>d1.time;
}
