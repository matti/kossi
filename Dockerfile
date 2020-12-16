FROM k0sproject/k0s:v0.8.1

COPY --from=jpillora/chisel:1.7.3 /app/chisel /usr/bin
COPY --from=m3ng9i/ran /ran /usr/bin

COPY app/ /app/
ENTRYPOINT [ "/app/entrypoint.sh" ]
