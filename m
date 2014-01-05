Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 06 Jan 2014 03:07:16 +0800
Message-ID: <2109637.jlPLNyN0nR@diderot>
In-Reply-To: <1388912394-824-2-git-send-email-antonio@meshcoding.com>
References: <1388912394-824-1-git-send-email-antonio@meshcoding.com>
 <1388912394-824-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2520014.MIHMIfxK0T";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next 2/3] batctl: implement vlan-to-link
	helper functions
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart2520014.MIHMIfxK0T
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 05 January 2014 09:59:53 Antonio Quartulli wrote:
> +/**
> + * vlan_get_link_dump - receive and dump a get_link rtnl reply
> + * @sock: the socket to listen for the reply on
> + * @buf: pointer to the buffer where the reply has to be dumped to
> + * @buflen: length of the buffer
> + *
> + * Returns the amount of dumped bytes
> + */
> +static ssize_t vlan_get_link_dump(int sock, void *buf, size_t buflen)
> +{
> +	struct iovec iov;
> +	struct msghdr msg;
> +	struct sockaddr_nl nladdr;
> +	ssize_t ret = -1;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	memset(&iov, 0, sizeof(iov));
> +
> +	msg.msg_iov = &iov;
> +	msg.msg_iovlen = 1;
> +	msg.msg_controllen = 0;
> +	msg.msg_control = NULL;
> +	msg.msg_flags = 0;
> +	msg.msg_name = &nladdr;
> +	msg.msg_namelen = sizeof(nladdr);
> +
> +	iov.iov_len = buflen;
> +	iov.iov_base = buf;
> +
> +	ret = recvmsg(sock, &msg, 0);
> +	if (ret < 0)
> +		goto err;
> +
> +	return ret;
> +err:
> +	free(buf);
> +	return ret;
> +}

Do we double free 'buf' in case of an error ?


> +/**
> + * vlan_get_link_open - send a get_link request
> + * @ifname: the interface to query
> + *
> + * Returns 0 in case of success or a negative error code otherwise
> + */
> +static int vlan_get_link_open(const char *ifname)
> +{
> +	struct {
> +		struct nlmsghdr hdr;
> +		struct ifinfomsg ifi;
> +		/* attribute has to be NLMAG aligned */

NLMSG aligned ?


Cheers,
Marek
--nextPart2520014.MIHMIfxK0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSya1oAAoJEFNVTo/uthzADYUH/2i40wP+jXD1EqukqgYoPuJg
qIhg6j2N9/OK4px0gpV+JVsow/cL73HnhFoyqJ2gtHsefMjPKaLFJ7GL8W+rBZar
OfsoDncYFG+47tm3vvnoMs/Z+nAZDdDDJmIfkWp456qTp35DfaiLBJEMK15l0p37
PeDCREkd+YPCLX0lTNv5HXVaoIWlb+5urN+48x+huPCF0HKrZBuCKWB8xL46L+L/
LB+3IpAOQW4ehIudII0aZ4Xda+bi6eD5ue0mOsbrjJemnWS2p9CZZ4ATFuI9SsDD
zRbO3a9cxWNHeWUDzH1UzQq2j7bh//Bg+jJ66E0ZNbJR0u+6yWikNvnsvtzHcyo=
=zaCO
-----END PGP SIGNATURE-----

--nextPart2520014.MIHMIfxK0T--

