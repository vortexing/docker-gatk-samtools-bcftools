# build as vortexing/gatk-samtools-bcftools:4.1.8.0-1.10-1.9
FROM broadinstitute/gatk:4.1.8.0


RUN apt-get update && apt-get -y upgrade && \
	apt-get install -y build-essential wget \
		libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev \
		libcurl3-dev autoconf automake make gcc perl libssl-dev \
		libperl-dev libgsl0-dev parallel
		
WORKDIR /
RUN wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 && \
	tar jxf samtools-1.10.tar.bz2 && \
	rm samtools-1.10.tar.bz2 && \
	cd samtools-1.10 && \
	make 
ENV PATH=${PATH}:/samtools-1.10

# Add on bcftools
WORKDIR /
RUN wget https://github.com/samtools/bcftools/releases/download/1.9/bcftools-1.9.tar.bz2 && \
	tar jxf bcftools-1.9.tar.bz2 && \
	rm bcftools-1.9.tar.bz2 && \
	cd bcftools-1.9 && \
	make install

WORKDIR /gatk