Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 09 May 2016 15:33:25 +0200
Message-ID: <3082168.4WeLqNseqL@bentobox>
In-Reply-To: <1462372207-28322-1-git-send-email-andrew@lunn.ch>
References: <1462372207-28322-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1490686.2OeEGBQTdK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batctl: Use netlink to replace some of
	debugfs
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

--nextPart1490686.2OeEGBQTdK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 04 May 2016 16:30:07 Andrew Lunn wrote:
> +int netlink_print_originators(char *mesh_iface, int read_opts,
> +                             float orig_timeout,
> +                             float watch_interval)
> +{
> +       char *header;
> +       int ifindex;
> +
> +       ifindex = if_nametoindex(mesh_iface);
> +       if (!ifindex) {
> +               fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
> +               return -ENODEV;
> +       }
> +
> +       netlink_print_info(ifindex, PARSE_ONLY);
> +
> +       if (!algo_name)
> +               return -EINVAL;
> +
> +       if (!strcmp("BATMAN_IV", algo_name))
> +               header = "   Originator        last-seen (#/255) Nexthop           [outgoingIF]\n";
> +       if (!strcmp("BATMAN_V", algo_name))
> +               header = "   Originator        last-seen (throughput) Nexthop           [outgoingIF]\n ";
> +
> +       if (!header)
> +               return -EINVAL;
> +
> +       return netlink_print_common(mesh_iface, read_opts, orig_timeout,
> +                                   watch_interval, header,
> +                                   BATADV_CMD_GET_ORIGINATORS,
> +                                   originators_callback);
> +}

This is actually a report of a possible problem by Simon (I've only
checked it):

It looks like the orig_iface handling isn't handled here (see
handle_debug_table "case 'i'") or am I missing something? I would have
expected that sets something like BATADV_ATTR_HARD_IFINDEX when
orig_iface is available and the kernel then shows the same as in
/sys/kernel/debug/batman_adv/$(hardif)/originators

The parameter BATADV_ATTR_HARD_IFINDEX seems to be already parsed
by batadv_orig_dump. But batctl never seems to set it.

Kind regards,
	Sven
--nextPart1490686.2OeEGBQTdK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMJGlAAoJEF2HCgfBJntGxPUP/i2f2CxSe4u11FJu+y3N9ecj
Pqgjh2jeEHDvYwBXO1sOy+cJta3sEajQ33P/nQRK5j+NX3SwKC5Dii2hlbdtVLwV
Bp9yEkKarRp/SrSindHooKQg5yCEHgtaTpXQl8YMp6U1oXdJCg3GiilXjYBYOBax
2TqQz713gqM+txbI8Fsu0jPE3Y5C+Je6cmIpqUWYCG9pR1Kh3Hmh+bOZ+30DWELa
8l/eyJYxerg5oz7zQS1+veq+PbTkhyH77jBM8XnSxtUEMIM4m76IFjx06Kr/eTsr
X4YIYpUe9bMriDMXAMA1L0dIf5vnvrtEcwJyPNbxSz4bx9NW/nxi+PiCygQO578V
xiCmRcNasFxTA0HyfoQfgShETpyMWoUyky3xQdiZfHRnlLsuTyQ7xPFveuY3Fm+O
SFZ/nD2ptu6/lJt58F1NilwdFiFXnFl4M0696was6VtXL/wFajnPJZF1J+UO2zlu
oGtgETtaQ5tGfNwctP4yUXA9Se13qRFC28J7gUWBtJZAkoqnyqMWaBiTOo9mKb2B
dV7iGJdB4VOYzrFsowwThKcTM8YIW9HKEKG/IaBxOpz+s0FuLHmmPNh1pcyG3mlL
AX3YmVtt/ErbLQB9HvvAcN2KxRNw/t4Q7hrVRF4HsmNEMLb90gb7OJW6rEbJ0fEJ
m+MNj17Nd8ICtp1XK3D1
=SRvN
-----END PGP SIGNATURE-----

--nextPart1490686.2OeEGBQTdK--

