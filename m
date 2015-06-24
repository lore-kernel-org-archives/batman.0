Return-Path: <mschiffer@universe-factory.net>
References: <2ce4491cf3eb01922d0fec97147a1533cca30c41.1435170868.git.mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <558AFE4E.7040107@universe-factory.net>
Date: Wed, 24 Jun 2015 21:00:30 +0200
MIME-Version: 1.0
In-Reply-To: <2ce4491cf3eb01922d0fec97147a1533cca30c41.1435170868.git.mschiffer@universe-factory.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gFmGtGVn8S2J9kKr6wJRnSPldIMqQTPBR"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: add generic netlink query API
 to replace debugfs files
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gFmGtGVn8S2J9kKr6wJRnSPldIMqQTPBR
Content-Type: multipart/mixed;
 boundary="------------050806030204080002050009"

This is a multi-part message in MIME format.
--------------050806030204080002050009
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

This is the mentioned userspace tool.
Build with:

cc -o batnl batnl.c $(pkg-config --cflags --libs libnl-1) -Wall

It uses the outdated libnl-1 instead of the current libnl-3 API to be
compatible with OpenWrt's libnl-tiny.

It is only a quick-and-dirty example for the usage of the GENL API, so
it doesn't check for a lot of errors...

Regards,
Matthias

--------------050806030204080002050009
Content-Type: text/x-csrc;
 name="batnl.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="batnl.c"

#include <stdio.h>
#include <string.h>

#include <net/if.h>
#include <netlink/netlink.h>
#include <netlink/genl/genl.h>
#include <netlink/genl/ctrl.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include "batman_adv.h"


static void usage()
{
	fprintf(stderr, "Usage:\n\n");
	fprintf(stderr, "  batnl <mesh> info\n");
	fprintf(stderr, "  batnl <mesh> translocal\n");
	fprintf(stderr, "  batnl <mesh> transglobal\n");
	fprintf(stderr, "  batnl <mesh> originators [<outgoing>]\n");
	exit(2);
}

static int print_error(struct sockaddr_nl *nla, struct nlmsgerr *nlerr, v=
oid *arg)
{
	fprintf(stderr, "Error received: %s\n", strerror(-nlerr->error));
	exit(1);
}

static int info_callback(struct nl_msg *msg, void *arg)
{
	struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
	struct genlmsghdr *ghdr;
	struct nlattr *attrs[BATADV_ATTR_MAX+1];

	if (!genlmsg_valid_hdr(nlh, 0)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	ghdr =3D nlmsg_data(nlh);

	if (ghdr->cmd !=3D BATADV_CMD_GET_MESH_INFO)
		return NL_OK;

	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0), genlmsg=
_len(ghdr), NULL)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	const char *mesh_name =3D nla_get_string(attrs[BATADV_ATTR_MESH_IFNAME])=
;

	if (attrs[BATADV_ATTR_PRIMARY_IFNAME]) {
		const char *version =3D nla_get_string(attrs[BATADV_ATTR_VERSION]);
		const char *algo_name =3D nla_get_string(attrs[BATADV_ATTR_ALGO_NAME]);=

		const char *primary_if =3D nla_get_string(attrs[BATADV_ATTR_PRIMARY_IFN=
AME]);
		const uint8_t *primary_mac =3D nla_data(attrs[BATADV_ATTR_PRIMARY_ADDRE=
SS]);

		printf("[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%02x:%02x:%02x:%02x:%02x:%=
02x (%s %s)]\n",
		       version, primary_if,
		       primary_mac[0], primary_mac[1], primary_mac[2],
		       primary_mac[3], primary_mac[4], primary_mac[5],
		       mesh_name, algo_name);

	}
	else {
		printf("BATMAN mesh %s disabled\n", mesh_name);
	}

	return NL_STOP;
}

static void info(struct nl_handle *sock, int family, int ifindex)
{
	struct nl_msg *msg;
	struct nl_cb *cb;

	msg =3D nlmsg_alloc();
	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, 0, BATADV_CMD_GET_=
MESH_INFO, 1);

	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);

	nl_send_auto_complete(sock, msg);

	nlmsg_free(msg);

	cb =3D nl_cb_alloc(NL_CB_DEFAULT);
	nl_cb_set (cb, NL_CB_VALID, NL_CB_CUSTOM, info_callback, NULL);
	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);

	nl_recvmsgs(sock, cb);
}

static int stop_callback(struct nl_msg *msg, void *arg)
{
	struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
	int *error =3D nlmsg_data(nlh);

	if (*error)
		fprintf(stderr, "Error received: %s\n", strerror(-*error));

	return NL_STOP;
}

static int translocal_callback(struct nl_msg *msg, void *arg)
{
	struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
	struct genlmsghdr *ghdr;
	struct nlattr *attrs[BATADV_ATTR_MAX+1];

	if (!genlmsg_valid_hdr(nlh, 0)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	ghdr =3D nlmsg_data(nlh);

	if (ghdr->cmd !=3D BATADV_CMD_GET_TRANSTABLE_LOCAL)
		return NL_OK;

	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0), genlmsg=
_len(ghdr), NULL)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	uint8_t *addr =3D nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
	int16_t vid =3D nla_get_u16(attrs[BATADV_ATTR_TT_VID]);
	uint32_t crc32 =3D nla_get_u32(attrs[BATADV_ATTR_TT_CRC32]);
	int last_seen_msecs =3D 0, last_seen_secs =3D 0;

	char r =3D '.', p =3D '.', n =3D '.', x =3D '.', w =3D '.', i =3D '.';
	if (attrs[BATADV_ATTR_FLAG_ROAM])
		r =3D 'R';
	if (attrs[BATADV_ATTR_FLAG_NEW])
		n =3D 'N';
	if (attrs[BATADV_ATTR_FLAG_PENDING])
		x =3D 'X';
	if (attrs[BATADV_ATTR_FLAG_WIFI])
		w =3D 'W';
	if (attrs[BATADV_ATTR_FLAG_ISOLA])
		i =3D 'I';

	if (attrs[BATADV_ATTR_FLAG_NOPURGE])  {
		p =3D 'P';
	}
	else {
		last_seen_msecs =3D nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
		last_seen_secs =3D last_seen_msecs / 1000;
		last_seen_msecs =3D last_seen_msecs % 1000;
	}


	printf(" * %02x:%02x:%02x:%02x:%02x:%02x %4i [%c%c%c%c%c%c] %3u.%03u   (=
0x%.8x)\n",
	       addr[0], addr[1], addr[2],
	       addr[3], addr[4], addr[5],
	       vid, r, p, n, x, w, i,
	       last_seen_secs, last_seen_msecs,
	       crc32);

	return NL_OK;
}

static void translocal(struct nl_handle *sock, int family, int ifindex)
{
	struct nl_msg *msg;
	struct nl_cb *cb;

	msg =3D nlmsg_alloc();
	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_DUMP, BATADV=
_CMD_GET_TRANSTABLE_LOCAL, 1);

	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);

	nl_send_auto_complete(sock, msg);

	nlmsg_free(msg);

	cb =3D nl_cb_alloc(NL_CB_DEFAULT);
	nl_cb_set (cb, NL_CB_VALID, NL_CB_CUSTOM, translocal_callback, NULL);
	nl_cb_set (cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);

	nl_recvmsgs(sock, cb);
}

static int transglobal_callback(struct nl_msg *msg, void *arg)
{
	struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
	struct genlmsghdr *ghdr;
	struct nlattr *attrs[BATADV_ATTR_MAX+1];

	if (!genlmsg_valid_hdr(nlh, 0)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	ghdr =3D nlmsg_data(nlh);

	if (ghdr->cmd !=3D BATADV_CMD_GET_TRANSTABLE_GLOBAL)
		return NL_OK;

	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0), genlmsg=
_len(ghdr), NULL)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	uint8_t *addr =3D nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
	uint8_t *orig =3D nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
	int16_t vid =3D nla_get_u16(attrs[BATADV_ATTR_TT_VID]);
	uint8_t ttvn =3D nla_get_u8(attrs[BATADV_ATTR_TT_TTVN]);
	uint8_t last_ttvn =3D nla_get_u8(attrs[BATADV_ATTR_TT_LAST_TTVN]);
	uint32_t crc32 =3D nla_get_u32(attrs[BATADV_ATTR_TT_CRC32]);

	char c =3D '+', r =3D '.', w =3D '.', i =3D '.', t =3D '.';
	if (attrs[BATADV_ATTR_FLAG_BEST])
		c =3D '*';
	if (attrs[BATADV_ATTR_FLAG_ROAM])
		r =3D 'R';
	if (attrs[BATADV_ATTR_FLAG_WIFI])
		w =3D 'W';
	if (attrs[BATADV_ATTR_FLAG_ISOLA])
		i =3D 'I';
	if (attrs[BATADV_ATTR_FLAG_TEMP])
		t =3D 'T';


	printf(" %c %02x:%02x:%02x:%02x:%02x:%02x %4i   (%3u) via %02x:%02x:%02x=
:%02x:%02x:%02x     (%3u)   (0x%.8x) [%c%c%c%c]\n",
	       c,
	       addr[0], addr[1], addr[2],
	       addr[3], addr[4], addr[5],
	       vid, ttvn,
	       orig[0], orig[1], orig[2],
	       orig[3], orig[4], orig[5],
	       last_ttvn, crc32, r, w, i, t);

	return NL_OK;
}

static void transglobal(struct nl_handle *sock, int family, int ifindex)
{
	struct nl_msg *msg;
	struct nl_cb *cb;

	msg =3D nlmsg_alloc();
	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_DUMP, BATADV=
_CMD_GET_TRANSTABLE_GLOBAL, 1);

	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);

	nl_send_auto_complete(sock, msg);

	nlmsg_free(msg);

	cb =3D nl_cb_alloc(NL_CB_DEFAULT);
	nl_cb_set (cb, NL_CB_VALID, NL_CB_CUSTOM, transglobal_callback, NULL);
	nl_cb_set (cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);

	nl_recvmsgs(sock, cb);
}

static int originators_callback(struct nl_msg *msg, void *arg)
{
	struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
	struct genlmsghdr *ghdr;
	struct nlattr *attrs[BATADV_ATTR_MAX+1];

	if (!genlmsg_valid_hdr(nlh, 0)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	ghdr =3D nlmsg_data(nlh);

	if (ghdr->cmd !=3D BATADV_CMD_GET_ORIGINATORS)
		return NL_OK;

	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0), genlmsg=
_len(ghdr), NULL)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	uint8_t *orig =3D nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
	uint8_t *neigh =3D nla_data(attrs[BATADV_ATTR_NEIGH_ADDRESS]);
	uint8_t tq =3D nla_get_u8(attrs[BATADV_ATTR_TQ]);

	char ifname[IF_NAMESIZE];
	if (!if_indextoname(nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]), ifname=
))
		ifname[0] =3D '\0';

	char c =3D '+';
	if (attrs[BATADV_ATTR_FLAG_BEST])
		c =3D '*';

	int last_seen_msecs, last_seen_secs;
	last_seen_msecs =3D nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
	last_seen_secs =3D last_seen_msecs / 1000;
	last_seen_msecs =3D last_seen_msecs % 1000;

	printf(" %c %02x:%02x:%02x:%02x:%02x:%02x %4i.%03is   (%3i) %02x:%02x:%0=
2x:%02x:%02x:%02x [%10s]\n",
	       c,
	       orig[0], orig[1], orig[2],
	       orig[3], orig[4], orig[5],
	       last_seen_secs, last_seen_msecs, tq,
	       neigh[0], neigh[1], neigh[2],
	       neigh[3], neigh[4], neigh[5],
	       ifname);

	return NL_OK;
}

static void originators(struct nl_handle *sock, int family, int ifindex, =
int outgoing_ifindex)
{
	struct nl_msg *msg;
	struct nl_cb *cb;

	msg =3D nlmsg_alloc();
	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_DUMP, BATADV=
_CMD_GET_ORIGINATORS, 1);

	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);

	if (outgoing_ifindex)
		nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, outgoing_ifindex);

	nl_send_auto_complete(sock, msg);

	nlmsg_free(msg);

	cb =3D nl_cb_alloc(NL_CB_DEFAULT);
	nl_cb_set (cb, NL_CB_VALID, NL_CB_CUSTOM, originators_callback, NULL);
	nl_cb_set (cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);

	nl_recvmsgs(sock, cb);
}

int main(int argc, char *argv[])
{
	struct nl_handle *sock;
	int family;

	sock =3D nl_handle_alloc();
	genl_connect(sock);

	family =3D genl_ctrl_resolve(sock, BATADV_NL_NAME);
	if (family < 0) {
		fputs("Your kernel doesn't support the batman-adv netlink interface.\n"=
, stderr);
		exit(1);
	}

	if (argc !=3D 3 && argc !=3D 4)
		usage();

	int ifindex =3D if_nametoindex(argv[1]);
	if (!ifindex)
		usage();

	int outgoing_ifindex =3D 0;

	if (argc =3D=3D 4) {
		outgoing_ifindex =3D if_nametoindex(argv[3]);
		if (!outgoing_ifindex)
			usage();
	}

	if (!strcmp(argv[2], "info"))
		info(sock, family, ifindex);
	else if (!strcmp(argv[2], "translocal"))
		translocal(sock, family, ifindex);
	else if (!strcmp(argv[2], "transglobal"))
		transglobal(sock, family, ifindex);
	else if (!strcmp(argv[2], "originators"))
		originators(sock, family, ifindex, outgoing_ifindex);
	else
		usage();

	return 0;
}

--------------050806030204080002050009--

--gFmGtGVn8S2J9kKr6wJRnSPldIMqQTPBR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJViv5OAAoJEBbvP2TLIB2c2UwP/2HoTfQKowPbDFL1J/QB45Mq
oBBJo9UFQz80j3rhNeG8qSzf7G00PY2EQ/ITLh4Xh3q3sQkSNGpoW3usGFf6N4eO
Z5MDYUIk4nxdMvzGrc4ossXNn7hurTYcpoFtDQttGJn+zWzqf8fyUinVL3sWUstL
zyV3m2xveuNCWZ0uWMMW1WcR3of8iuQGWefKhDtrMtHY1VNWCPWOfbFH/XjtidLw
E7aX/bfPAxH3VQOGvfPVCvvhv3tZjqP1i8F6fBFCnuz/RHRYLkjpqFzuBU9OUBkE
G/8V8IFu9mpjWA0GucMesJ7xo+2K5c3J3OIVqMDPwEnnqHo49qwaMjjLD3hWW4Uw
nkovKdD9Fqax5ojEBCmKQlO40hTGPxW0CDfwHj5+7oHuk5E/aPPUDjV6aXk6iraR
diolVyy3GPWArTUan9LQuDenUBeNWs8iL9LIIunnLTgpq+KgpAnVxXE9s35XpnEw
Tmi7y/Sy39E9tyCfdJ0dkxCOOS8kygdLq4v+fDwAmdps2aOVH+26dpx1JEEscP53
RnpF2QrcH7oCLXnJS3qT2/2LxETdaBUuIXy7lJw5KLX1tFdKeXVkwpBcsn8xvINm
ksenCm2/SO9NbQ5BsBBgFc+DKawp5iS1DNpc8nhSo7RJ4aygHCtCsVAcyc2zYLty
9jJ10pLZqC+CdNtYAwYB
=abor
-----END PGP SIGNATURE-----

--gFmGtGVn8S2J9kKr6wJRnSPldIMqQTPBR--
