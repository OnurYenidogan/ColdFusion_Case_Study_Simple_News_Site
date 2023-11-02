CREATE TABLE Categories (
    categoryID INT PRIMARY KEY IDENTITY(1,1),
    categoryName NVARCHAR(255)
);
GO

CREATE TABLE News (
    newsID INT PRIMARY KEY IDENTITY(1,1),
    title NVARCHAR(255),
    content NVARCHAR(MAX),
    categoryID INT,
    FOREIGN KEY (categoryID) REFERENCES Categories(categoryID)
);
GO