FROM wuzapi/wuzapi:latest

ENV WUZAPI_ADMIN_USER=admin
ENV WUZAPI_ADMIN_PASS=lolstr7@LOL
ENV PORT=8080

EXPOSE 8080

CMD ["npm", "start"]
