const errorHandler = (err, req, res, next) => {
  res.status(err.status || 504).json({
    message: err.message || 'Internal Server Error',
    stack: process.env.NODE_ENV === 'development' ? err.stack : {},
  });
};

export { errorHandler };
