import React from 'react';
import BookDetails from './components/BookDetails';
import BlogDetails from './components/BlogDetails';
import CourseDetails from './components/CourseDetails';
import { books, blogs, courses } from './data';
import './App.css';

function App() {
  return (
    <div className="container">
      <div className="column"><CourseDetails courses={courses} /></div>
      <div className="column"><BookDetails books={books} /></div>
      <div className="column"><BlogDetails blogs={blogs} /></div>
    </div>
  );
}

export default App;
