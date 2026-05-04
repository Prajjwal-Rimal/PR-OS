    // GDT IN C
    // describe it like a segment descriptor
    // loaded exactly the way it is defined
    // https://www.youtube.com/watch?v=jwulDRMQ53I


    struct gdt_entry
    {
        __UINT16_TYPE__ limit;
        __UINT16_TYPE__ baselow;
        __UINT8_TYPE__ basemiddle;
        __UINT8_TYPE__ access;
        __UINT8_TYPE__ flag;
        __UINT8_TYPE__ basehigh;
    }__attribute__((packed));
    //attribute packed tells to define the memory the way we have defined it doing so make it that there is no extra padding in the struct
   
    struct gdt_ptr
    {
        __UINT16_TYPE__ limit;
        unsigned int base;
    }__attribute__((packed));

    void initgdt();
    
    void gdtgate (__UINT32_TYPE__ num, __UINT32_TYPE__ base, __UINT32_TYPE__ limit, __UINT8_TYPE__ access, __UINT8_TYPE__ granularity );
    