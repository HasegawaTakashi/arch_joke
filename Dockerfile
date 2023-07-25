FROM archlinux:base-20230723.0.166908

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm fortune-mod cowsay cmatrix sl ruby figlet lolcat && \
    echo 'cmatrix cmatrix/question select false\n\
    cmatrix cmatrix/install-setuid select true\n\
    cmatrix cmatrix/terminal-frames select false\n\
    cmatrix cmatrix/disable-setuid select false\n\
    cmatrix cmatrix/use-suid select true\n\
    ' | pacman -S --noconfirm cmatrix && \
    curl -sSL https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS -o /etc/DIR_COLORS && \
    echo 'alias moo="fortune | cowsay -f $(ls /usr/share/cows/ | shuf -n 1) | lolcat"' >> ~/.bashrc && \
    echo 'alias snow="bash /usr/src/app/snow.sh"' >> ~/.bashrc && \
    echo 'alias starwars="telnet towel.blinkenlights.nl"' >> ~/.bashrc && \
    pacman -Scc --noconfirm

RUN useradd -ms /bin/bash newuser
USER newuser

WORKDIR /usr/src/app

COPY snow.sh .
COPY command.txt .

CMD ["/bin/bash"]
