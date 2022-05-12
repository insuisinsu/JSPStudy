Create Table freeboard (
    id  number constraint PK_freeboard_id Primary key ,    --자동 증가 컬럼
    name varchar2(100) not null, 
    password varchar2(100) null, 
    email varchar2 (100) null, 
    subject varchar2(100) not null, --글제목
    content varchar2(2000) not null, -- 글내용
    inputdate varchar2(100) not null, -- 글쓴 날짜 
    masterid number default 0 , -- 질문 답변형 계시판에서 답변의 글을 그룹핑 
    readcount number default 0, -- 글 조회수 
    replaynum number default 0,
    step number default 0 
    ); 
    
 select * from freeboard  
 
 
 
 
 
 
 ==================================
 
 
=============================



Create Table freeboard (
    id  number constraint PK_freeboard_id Primary key ,    --자동 증가 컬럼
    name varchar2(100) not null, 
    password varchar2(100) null, 
    email varchar2 (100) null, 
    subject varchar2(100) not null, --글제목
    content varchar2(2000) not null, -- 글내용
    inputdate varchar2(100) not null, -- 글쓴 날짜 
    masterid number default 0 , -- 질문 답변형 계시판에서 답변의 글을 그룹핑 
    readcount number default 0, -- 글 조회수 
    replaynum number default 0,
    step number default 0 
    ); 
    
 select * from freeboard  
 
delete freeboard 
commit; 
 
 INSERT INTO freeboard (id, name, password, email, subject, 
        content, 
        inputdate,  masterid, readcount, replaynum, step) 
values (1,'홍길동','1234','ccc@ccc.com','첫번째 글입니다. ',
    '첫 번째 내용입니다. 글 내용입니다. 글 내용 2 입니다. ',
        '22-05-11 11:52 오전',1,0,0,0)
        
 select * from freeboard where id = 3 
 desc freeboard; 
 
 
 -- 답변글이 존재하는 테이블을 출력 할때, 정렬을 잘 해서 가져 와야 한다. 
 select * from freeboard 
 order by masterid desc, replaynum asc, step asc, id asc
 
   -- masterid 컬럼에 중복된 값이 있을 경우, replaynum컬럼을 asc
   -- replaynum이 중복되 값이 존재 할때 step을 asc
   -- step 이 중복된 값이 존재할때 id asc 
 
 
 
 select * from freeboard
 order by id desc; 

 -- id 컬럼 : 새로운 글이 등록될때 기존의 id컬럼의 최대값을 가져와서 +1  <= 
        -- 새글 번호의 넘버링. 
--답변글을 처리하는 컬럼이 3개 필요하다. (masterid, replayNum, step )

 -- masterid     : 글의 답변에 대한 그룹핑 , 
        --id 컬럼의 값이 그대로 들어간 경우, 답변글이 아니다. 처음글
 
 -- replayNum  : 답변글에대한 넘버링. (1,2,3...)
 -- step       : 답변글의 깊이 
        -- 0 : 처음글 (자신의 글, 답변x)
        -- 1 : 답변글
        -- 2 : 답변의 답변
        -- 3 : 답변의 답변의 답변 
