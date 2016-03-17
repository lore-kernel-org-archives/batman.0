Return-Path: <mschiffer@universe-factory.net>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <56EAE3B8.3050808@universe-factory.net>
Date: Thu, 17 Mar 2016 18:04:56 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1458231707.git.mschiffer@universe-factory.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5cQKBkLAcMiS3bl5o4lqwIVBfRsDiB45h"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
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
--5cQKBkLAcMiS3bl5o4lqwIVBfRsDiB45h
Content-Type: multipart/mixed; boundary="spmC7UoIc5fX6NAEINFDAMX246SCwatqd"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <56EAE3B8.3050808@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
References: <cover.1458231707.git.mschiffer@universe-factory.net>
In-Reply-To: <cover.1458231707.git.mschiffer@universe-factory.net>

--spmC7UoIc5fX6NAEINFDAMX246SCwatqd
Content-Type: multipart/mixed;
 boundary="------------040206050708000103050908"

This is a multi-part message in MIME format.
--------------040206050708000103050908
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/17/2016 05:45 PM, Matthias Schiffer wrote:
> Hi,
> this is the second take of my netlink API patches. As mentioned before,=
 the
> netlink API is superior to the current debugfs API in many aspects:
>=20
> * debugfs is broken (see PATCH 1 for details)
> * Netlink is namespace-aware, and can be used in unprivileged container=
s
>   without problems
> * Netlink packets are more machine-readable than text files, and can be=

>   easily extended without potentially breaking userspace
> * On older kernels, seq_file can't fall back to vmalloc if kmalloc fail=
s,
>   which often leads to OOM when reading "originators" in large meshes, =
as
>   the whole file must fit into a single buffer
>=20
> Of course, are also a few downsides; when the data is too big to fit in=
to
> a single netlink packet, the provided data may be inconsistent (entries=
 may
> be missing or duplicated.) This will happen in large meshes only, and b=
e
> improbable in any case.
>=20
> The patches have been developed on top of the netns patchset, but shoul=
d
> be applicable independently (maybe with minor changes.)
>=20
> All netlink queries returning lists of any kind can only be used with
> NLM_F_DUMP queries, so that arbitrarity large responses are possible (s=
plit
> across multiple packets if necessary.)
>=20
> At the moment, the following debugfs files have corresponding netlink A=
PIs:
>=20
> * routing_algos
> * neighbors
> * originators
> * transtable_global
> * transtable_local
> * (hardinterfaces for a softif can be queried)
>=20
> The following files are still missing:
>=20
> * gateways
> * bla_claim_table
> * bla_backbone_table
> * dat_cache
> * nc_nodes
>=20
> Obviously, documentation is also a TODO. Comments about the API design =
are
> very welcome...
>=20
> Regards,
> Matthias
>=20
>=20

And here is the new version of the PoC userspace tool.
Build with:

gcc -o batnl batnl.c $$(pkg-config --cflags --libs libnl-1) -Wall


--------------040206050708000103050908
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
	fprintf(stderr, "  batnl routing_algos\n");
	fprintf(stderr, "  batnl info <mesh>\n");
	fprintf(stderr, "  batnl interface <mesh>\n");
	fprintf(stderr, "  batnl translocal <mesh>\n");
	fprintf(stderr, "  batnl transglobal <mesh>\n");
	fprintf(stderr, "  batnl neighbors <mesh> [<hardif>]\n");
	fprintf(stderr, "  batnl originators <mesh> [<hardif>]\n");
	exit(2);
}

static int print_error(struct sockaddr_nl *nla, struct nlmsgerr *nlerr, v=
oid *arg)
{
	fprintf(stderr, "Error received: %s\n", strerror(-nlerr->error));
	exit(1);
}

static int stop_callback(struct nl_msg *msg, void *arg)
{
	struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
	int *error =3D nlmsg_data(nlh);

	if (*error)
		fprintf(stderr, "Error received: %s\n", strerror(-*error));

	return NL_STOP;
}

static int routing_algos_callback(struct nl_msg *msg, void *arg)
{
	struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
	struct genlmsghdr *ghdr;
	struct nlattr *attrs[BATADV_ATTR_MAX+1];

	if (!genlmsg_valid_hdr(nlh, 0)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	ghdr =3D nlmsg_data(nlh);

	if (ghdr->cmd !=3D BATADV_CMD_GET_ROUTING_ALGOS)
		return NL_OK;

	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0), genlmsg=
_len(ghdr), NULL)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	const char *algo_name =3D nla_get_string(attrs[BATADV_ATTR_ALGO_NAME]);

	printf(" * %s\n", algo_name);

	return NL_OK;
}

static void routing_algos(struct nl_handle *sock, int family)
{
	struct nl_msg *msg;
	struct nl_cb *cb;

	msg =3D nlmsg_alloc();
	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_DUMP, BATADV=
_CMD_GET_ROUTING_ALGOS, 1);

	nl_send_auto_complete(sock, msg);

	nlmsg_free(msg);

	cb =3D nl_cb_alloc(NL_CB_DEFAULT);
	nl_cb_set (cb, NL_CB_VALID, NL_CB_CUSTOM, routing_algos_callback, NULL);=

	nl_cb_set (cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);

	nl_recvmsgs(sock, cb);
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

	if (attrs[BATADV_ATTR_HARD_IFNAME]) {
		const char *version =3D nla_get_string(attrs[BATADV_ATTR_VERSION]);
		const char *algo_name =3D nla_get_string(attrs[BATADV_ATTR_ALGO_NAME]);=

		const char *primary_if =3D nla_get_string(attrs[BATADV_ATTR_HARD_IFNAME=
]);
		const uint8_t *primary_mac =3D nla_data(attrs[BATADV_ATTR_HARD_ADDRESS]=
);

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

static int interface_callback(struct nl_msg *msg, void *arg)
{
	struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
	struct genlmsghdr *ghdr;
	struct nlattr *attrs[BATADV_ATTR_MAX+1];

	if (!genlmsg_valid_hdr(nlh, 0)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	ghdr =3D nlmsg_data(nlh);

	if (ghdr->cmd !=3D BATADV_CMD_GET_HARDIFS)
		return NL_OK;

	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0), genlmsg=
_len(ghdr), NULL)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	const char *ifname =3D nla_get_string(attrs[BATADV_ATTR_HARD_IFNAME]);

	printf("%s: %sactive\n", ifname, attrs[BATADV_ATTR_ACTIVE] ? "" : "in");=


	return NL_OK;
}

static void interface(struct nl_handle *sock, int family, int ifindex)
{
	struct nl_msg *msg;
	struct nl_cb *cb;

	msg =3D nlmsg_alloc();
	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_DUMP, BATADV=
_CMD_GET_HARDIFS, 1);

	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);

	nl_send_auto_complete(sock, msg);

	nlmsg_free(msg);

	cb =3D nl_cb_alloc(NL_CB_DEFAULT);
	nl_cb_set (cb, NL_CB_VALID, NL_CB_CUSTOM, interface_callback, NULL);
	nl_cb_set (cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);

	nl_recvmsgs(sock, cb);
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
	uint32_t flags =3D nla_get_u32(attrs[BATADV_ATTR_TT_FLAGS]);
	int last_seen_msecs =3D 0, last_seen_secs =3D 0;

	char r =3D '.', p =3D '.', n =3D '.', x =3D '.', w =3D '.', i =3D '.';
	if (flags & BATADV_TT_CLIENT_ROAM)
		r =3D 'R';
	if (flags & BATADV_TT_CLIENT_NEW)
		n =3D 'N';
	if (flags & BATADV_TT_CLIENT_PENDING)
		x =3D 'X';
	if (flags & BATADV_TT_CLIENT_WIFI)
		w =3D 'W';
	if (flags & BATADV_TT_CLIENT_ISOLA)
		i =3D 'I';

	if (flags & BATADV_TT_CLIENT_NOPURGE)  {
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
	uint32_t flags =3D nla_get_u32(attrs[BATADV_ATTR_TT_FLAGS]);

	char c =3D '+', r =3D '.', w =3D '.', i =3D '.', t =3D '.';
	if (attrs[BATADV_ATTR_FLAG_BEST])
		c =3D '*';
	if (flags & BATADV_TT_CLIENT_ROAM)
		r =3D 'R';
	if (flags & BATADV_TT_CLIENT_WIFI)
		w =3D 'W';
	if (flags & BATADV_TT_CLIENT_ISOLA)
		i =3D 'I';
	if (flags & BATADV_TT_CLIENT_TEMP)
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

	if (attrs[BATADV_ATTR_THROUGHPUT]) {
		unsigned throughput_mbits, throughput_kbits;
		throughput_kbits =3D nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
		throughput_mbits =3D throughput_kbits / 1000;
		throughput_kbits =3D throughput_kbits % 1000;

		printf(" %c %02x:%02x:%02x:%02x:%02x:%02x %4i.%03is (%9u.%1u) %02x:%02x=
:%02x:%02x:%02x:%02x [%10s]\n",
		       c,
		       orig[0], orig[1], orig[2],
		       orig[3], orig[4], orig[5],
		       last_seen_secs, last_seen_msecs,
		       throughput_mbits, throughput_kbits / 100,
		       neigh[0], neigh[1], neigh[2],
		       neigh[3], neigh[4], neigh[5],
		       ifname);
	}
	else {
		uint8_t tq =3D nla_get_u8(attrs[BATADV_ATTR_TQ]);

		printf(" %c %02x:%02x:%02x:%02x:%02x:%02x %4i.%03is   (%3i) %02x:%02x:%=
02x:%02x:%02x:%02x [%10s]\n",
		       c,
		       orig[0], orig[1], orig[2],
		       orig[3], orig[4], orig[5],
		       last_seen_secs, last_seen_msecs, tq,
		       neigh[0], neigh[1], neigh[2],
		       neigh[3], neigh[4], neigh[5],
		       ifname);
	}

	return NL_OK;
}

static void originators(struct nl_handle *sock, int family, int ifindex, =
int hard_ifindex)
{
	struct nl_msg *msg;
	struct nl_cb *cb;

	msg =3D nlmsg_alloc();
	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_DUMP, BATADV=
_CMD_GET_ORIGINATORS, 1);

	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);

	if (hard_ifindex)
		nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, hard_ifindex);

	nl_send_auto_complete(sock, msg);

	nlmsg_free(msg);

	cb =3D nl_cb_alloc(NL_CB_DEFAULT);
	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, originators_callback, NULL);
	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);

	nl_recvmsgs(sock, cb);
}

static int neighbors_callback(struct nl_msg *msg, void *arg)
{
	struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
	struct genlmsghdr *ghdr;
	struct nlattr *attrs[BATADV_ATTR_MAX+1];

	if (!genlmsg_valid_hdr(nlh, 0)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	ghdr =3D nlmsg_data(nlh);

	if (ghdr->cmd !=3D BATADV_CMD_GET_NEIGHBORS)
		return NL_OK;

	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0), genlmsg=
_len(ghdr), NULL)) {
		fputs("Received invalid data from kernel.", stderr);
		exit(1);
	}

	uint8_t *neigh =3D nla_data(attrs[BATADV_ATTR_NEIGH_ADDRESS]);

	char ifname[IF_NAMESIZE];
	if (!if_indextoname(nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]), ifname=
))
		ifname[0] =3D '\0';

	int last_seen_msecs, last_seen_secs;
	last_seen_msecs =3D nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
	last_seen_secs =3D last_seen_msecs / 1000;
	last_seen_msecs =3D last_seen_msecs % 1000;

	if (attrs[BATADV_ATTR_THROUGHPUT]) {
		unsigned throughput_mbits, throughput_kbits;
		throughput_kbits =3D nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
		throughput_mbits =3D throughput_kbits / 1000;
		throughput_kbits =3D throughput_kbits % 1000;

		printf("%02x:%02x:%02x:%02x:%02x:%02x %4i.%03is (%9u.%1u) [%10s]\n",
		       neigh[0], neigh[1], neigh[2],
		       neigh[3], neigh[4], neigh[5],
		       last_seen_secs, last_seen_msecs,
		       throughput_mbits, throughput_kbits / 100,
		       ifname);
	}
	else {
		printf("   %10s   %02x:%02x:%02x:%02x:%02x:%02x %4i.%03is\n",
		       ifname,
		       neigh[0], neigh[1], neigh[2],
		       neigh[3], neigh[4], neigh[5],
		       last_seen_secs, last_seen_msecs);
	}

	return NL_OK;
}

static void neighbors(struct nl_handle *sock, int family, int ifindex, in=
t hard_ifindex)
{
	struct nl_msg *msg;
	struct nl_cb *cb;

	msg =3D nlmsg_alloc();
	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_DUMP, BATADV=
_CMD_GET_NEIGHBORS, 1);

	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);

	if (hard_ifindex)
		nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, hard_ifindex);

	nl_send_auto_complete(sock, msg);

	nlmsg_free(msg);

	cb =3D nl_cb_alloc(NL_CB_DEFAULT);
	nl_cb_set (cb, NL_CB_VALID, NL_CB_CUSTOM, neighbors_callback, NULL);
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

	if (argc < 2 || argc > 4)
		usage();

	int ifindex =3D 0;
	if (argc > 2) {
		ifindex =3D if_nametoindex(argv[2]);
		if (!ifindex)
			usage();
	}

	int hard_ifindex =3D 0;
	if (argc > 3) {
		hard_ifindex =3D if_nametoindex(argv[3]);
		if (!hard_ifindex)
			usage();
	}

	if (!strcmp(argv[1], "routing_algos"))
		routing_algos(sock, family);
	else if (!strcmp(argv[1], "info"))
		info(sock, family, ifindex);
	else if (!strcmp(argv[1], "interface"))
		interface(sock, family, ifindex);
	else if (!strcmp(argv[1], "translocal"))
		translocal(sock, family, ifindex);
	else if (!strcmp(argv[1], "transglobal"))
		transglobal(sock, family, ifindex);
	else if (!strcmp(argv[1], "originators"))
		originators(sock, family, ifindex, hard_ifindex);
	else if (!strcmp(argv[1], "neighbors"))
		neighbors(sock, family, ifindex, hard_ifindex);
	else
		usage();

	return 0;
}

--------------040206050708000103050908--

--spmC7UoIc5fX6NAEINFDAMX246SCwatqd--

--5cQKBkLAcMiS3bl5o4lqwIVBfRsDiB45h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJW6uO4AAoJEBbvP2TLIB2cU4cQANHIf8i3u7+Tjin6RdVRZoDT
74mkSRYxqCyNs3iPOepNt9JEHydEV3IusS45FnU9689SE0k5UMPuON9eJxUcHOWQ
HSJDY0V404ggkGyySmLjEH3+WSbEbqAp69D+OvTCeDPGj9QGPtBu/Omb3snRIqdX
E44kI/ty29brtlkXFxIjQRb5e4iee1wRGsp6gzY5AYhALHVoNJTYN9tcCOEQ0SFH
Tgav51AIq9Q9XyXnGlKapktvutiSND42OMkh2oscmL35a4Kzwdj/RCErPX+YBSq8
+NkA8nKMs+dYbCxKqrTs1TpfpFQmOkzr3ZrF9U0q7QtG7ulmrmJ7zTNaEc+197Sb
gJ/IGEVRb34ed4g8DAqrkUlSJchL5/eMOkhLXRdVHnRm/JUgJSybHO8F2NzhWG7K
8xU/N9IH2YwrlthvNUQFsIBg6fxsA/gBVcimXipPDM8uAGDSG2oQopD/Lw+jNS4P
kdsRiVQwTbgUBOVphyIAbyIQSQNWKWL+9aGGhoKCFFYnEpXDZs0gmNE/JKeHf21f
B9gbAamzQs52gpEegnP/szMRWV7cYbvwU1Po1witTf+GzrEUEcelMtHUyEmkTleR
84w3g7p+zrZEcfgUZYGvfYhSTyNYFI71v3jFoofHqRW854ZGWL1NQtM8yGCSncEV
FOGnrTjIpbMr4+CRVaQ/
=ZnbH
-----END PGP SIGNATURE-----

--5cQKBkLAcMiS3bl5o4lqwIVBfRsDiB45h--
