namespace com.training;

using {cuid, Country} from '@sap/cds/common';

//context school {
    
entity Course: cuid {
        Student : Association to many StudentCourse
                      on Student.Course = $self;

}

entity Student: cuid {
        Course : Association to many StudentCourse
                     on Course.Student = $self;


}

entity StudentCourse: cuid {
        Student : Association to Student;
        Course  : Association to Course;
}

entity Orders {
    key ClientEmail : String(65);
        FirstName   : String(30);
        LastName    : String(30);
        CreatedOn   : Date;
        Reviewed    : Boolean;
        Approved    : Boolean;
        Country     : Country;  
        Status      : String(1);
};

//}


//type emailsAddresses_01 : array of {
//    kind  : String;
//    email : String;
//}

//type emailsAddresses_02 : array of {
//    kind  : String;
//    email : String;
//}

//entity Email {
//    email_01  :      emailsAddresses_01;
//    email_02  : many emailsAddresses_02;
//    email_03  : many {
//        kind  :      String;
//        email :      String;
//    };
//};

type Dec : Decimal(16, 2);

//type Gender : String enum {
//    male;
//    female;
//};

//entity Order {
//    clientGender : Gender;
//    status       : Integer enum {
//        submitted = 1;
//        fulfiller = 2;
//        shipped   = 3;
//        cancel    = -1;
//    };
//    priority     : String @assert.range enum {
//        high;
//        medium;
//        low;
//    }

//};

//entity Car {
//    key id                : UUID;
//        name              : String;
//        virtual dicount_1 : Decimal;
//        virtual dicount_2 : Decimal;

//}