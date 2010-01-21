Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 21 Jan 2010 16:29:34 +0100
References: <20100119145806.275330@gmx.net>
	<201001210632.19709.lindner_marek@yahoo.de>
	<20100121141227.319490@gmx.net>
In-Reply-To: <20100121141227.319490@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2193935.oPNt4YLSRY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201001211629.37747.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2193935.oPNt4YLSRY
Content-Type: multipart/mixed;
  boundary="Boundary-01=_fLHWLlZDt25DNUz"
Content-Transfer-Encoding: 7bit


--Boundary-01=_fLHWLlZDt25DNUz
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Juha Yl=F6nen wrote:
> Yeah, I've been lurking there for a while, but being so much on/off from
>  the computer lately it's been easier to email. I'll certainly begin
>  bugging You through irc once I have time to sit down for a while..=3D)

It would help a lot. We are currently waiting for a lot more information fr=
om=20
you.

I think it isn't really a big endian vs. little endian problem. I have=20
installed batman-adv 1559 on a powerpc and on my amd64. Both can talk to ea=
ch=20
other without problems.

Do you have any filters installed which could filter out the ethernet frame=
s?=20
Does your hardware on arm transport non-standard ethernet types? A tcpdump =
on=20
both sides which we can compare would help a lot.

I usually use a small test program to send raw ethernet packets from one ho=
st=20
to another (one sided ping test). It helps a lot to find one directional=20
problems.

On one side you must use `./rawsend DEVICE` and on the other
`./rawsend DEVICE TARGET-MAC`

Best regards,
	Sven

--Boundary-01=_fLHWLlZDt25DNUz
Content-Type: text/x-csrc;
  charset="UTF-8";
  name="rawsend.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rawsend.c"

#include <stdio.h>
#include <sys/ioctl.h>
#include <net/if.h>=20
#include <sys/types.h>
#include <sys/socket.h>
#include <netpacket/packet.h>
#include <net/ethernet.h>
#include <stdint.h>
#include <string.h>
#include <arpa/inet.h>
#include <unistd.h>

int getmac(const char *src, unsigned char *dst)
{
	unsigned int n[6];
	int i;
	if (sscanf(src, "%x:%x:%x:%x:%x:%x",
	    &n[0], &n[1], &n[2], &n[3], &n[4], &n[5]) !=3D 6) {
		if(sscanf(src, "%2x%2x.%2x%2x.%2x%2x",
		   &n[0], &n[1], &n[2], &n[3], &n[4], &n[5]) !=3D 6) {
			return 1;
		}
	}

	for (i =3D 0; i < 6; i++) {
		if (n[i] <=3D 255)
			dst[i] =3D (unsigned char)n[i];
		else
			return 1;
	}

	return 0;
}

int main(int argc, char *argv[])
{
	int rawsock;
	uint16_t type =3D 0x1337;
	struct ifreq req;
	struct sockaddr_ll addr;
	struct iovec vector[2];
	char buf[256];
	size_t size =3D 256;
	struct ether_header header;

	if (argc !=3D 2 && argc !=3D 3) {
		fprintf(stderr, "Usage: %s DEVICE [DST-MAC]\n", argv[0]);
		return 1;
	}

	if ((rawsock =3D socket(PF_PACKET, SOCK_RAW, htons(type))) < 0 ) {
			fprintf(stderr, "Could not open raw socket\n");
			return 1;
	}

	strncpy(req.ifr_name, argv[1], IFNAMSIZ);
	if (ioctl(rawsock, SIOCGIFINDEX, &req) < 0) {
		fprintf(stderr, "Could not find device %s\n", argv[1]);
		return 1;
	}

	addr.sll_family =3D AF_PACKET;
	addr.sll_protocol =3D htons(type);
	addr.sll_ifindex  =3D req.ifr_ifindex;

	if (bind(rawsock, (struct sockaddr *)&addr, sizeof(addr)) < 0 ) {
		fprintf(stderr, "Could not bind to device %s\n", argv[1]);
		return 1;
	}

	strncpy(req.ifr_name, argv[1], IFNAMSIZ);
	if (ioctl(rawsock, SIOCGIFHWADDR, &req) < 0) {
		fprintf(stderr, "Could not get hwaddr of device %s\n", argv[1]);
		return 1;
	}

	if (argc =3D=3D 2) {
		vector[0].iov_base =3D &header;
		vector[0].iov_len  =3D sizeof(struct ether_header);
		vector[1].iov_base =3D buf;
		vector[1].iov_len  =3D size;

		if (readv(rawsock, vector, 2) < 0) {
			close(rawsock);
			fprintf(stderr, "Could not receive message\n");
			return 1;
		}
		printf("Received message\n");
	} else if (argc =3D=3D 3) {
		vector[0].iov_base =3D &header;
		vector[0].iov_len  =3D sizeof(struct ether_header);
		vector[1].iov_base =3D buf;
		vector[1].iov_len  =3D size;

		header.ether_type =3D htons(type);

		memcpy(header.ether_shost, req.ifr_hwaddr.sa_data, ETH_ALEN);

		if (getmac(argv[2], header.ether_dhost)) {
			close(rawsock);
			fprintf(stderr, "Could not parse mac address %s\n", argv[2]);
			return 1;
		}
		if (writev(rawsock, vector, 2) < 0) {
			close(rawsock);
			fprintf(stderr, "Could not send message\n");
			return 1;
		}
	}
	close(rawsock);
	return 0;
}

--Boundary-01=_fLHWLlZDt25DNUz--

--nextPart2193935.oPNt4YLSRY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLWHLfAAoJEF2HCgfBJntGX6gQAMAPDBgeY0qzgWmRKzDI7HKk
deWr1bwuNbN5Hogf8lpxhG4XhnTgvzFpXtsll+ncxDz1Vj43XZNe6XQjLxhU96Om
RQLDl9QFkW/Pj6pqlO9QO9+yqQyFWSdb8Isz0rlb4boRro8AEp8/4Bsbb0RUPrWq
LZq8G6ziMumsB40o7HFtFMLxysE8WRJ5n03QcwZk91NrN92HsoKP56NtrptdA/ds
dGc5N/Y6iiVvZzn500xOV02lft92kOeigcH21UxygLihOR/QAccGHAtSdyfg33yn
L77YF9cgZDIjXPfPsukkYjMcdrlS+XT21KUVN5HXrkuz/PHQY4NZ3F2+lfxAKM+4
RSw/qukObFHGGZfnagZI5H6TKp3PjbHM4F1YaNla/joHn4aKvQXoJsqywubh92Rc
ynOl1PvVKeKB0jAhiF41SYeQNeMTAwRIc92aoSOJsyFmBRwcz7gY/zWa1IKrdGtu
8NSXhgozxa88vw/92It4p6T7/EqYpnLXSOb7rcc2VfDJWecpqXoz/mTRpP5F6c3v
B2fcqWoeFxy+QkoYd8MbmdT0T4i2qKz8lC4dxtcUepODCMpbwmJZujYdPf1AASGN
5R1yyLOVvmi8frUVnW0Mic8AtvTv9Awo0WWH2Ngtei61TQi+ftxq/5bzR3hbhodv
1v585tWGfJGOe8u88xSd
=JNPg
-----END PGP SIGNATURE-----

--nextPart2193935.oPNt4YLSRY--
