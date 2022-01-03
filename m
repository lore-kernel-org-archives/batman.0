Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 4/4] alfred: introduce 'server status' IPC call
Date: Mon, 03 Jan 2022 10:09:23 +0100
Message-ID: <1933904.MC1LskztYI@sven-l14>
In-Reply-To: <20220102113136.470299-4-mareklindner@neomailbox.ch>
References: <3748133.vRqKQLy7FI@rousseau>
 <20220102113136.470299-1-mareklindner@neomailbox.ch>
 <20220102113136.470299-4-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9120863.S1E0kk7kuN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

 
--nextPart9120863.S1E0kk7kuN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH 4/4] alfred: introduce 'server status' IPC call
Date: Mon, 03 Jan 2022 10:09:23 +0100
Message-ID: <1933904.MC1LskztYI@sven-l14>
In-Reply-To: <20220102113136.470299-4-mareklindner@neomailbox.ch>
References: <3748133.vRqKQLy7FI@rousseau> <20220102113136.470299-1-mareklindner@neomailbox.ch> <20220102113136.470299-4-mareklindner@neomailbox.ch>

On Sunday, 2 January 2022 12:31:36 CET Marek Lindner wrote:
> +struct alfred_server_status_rep_v0 {
> +       struct alfred_tlv header;
> +       uint8_t mode;
> +       struct {
> +               char name[IFNAMSIZ];
> +       } ifaces[16];
> +       char bat_iface[IFNAMSIZ];
>  } __packed;

Another thing which came to my mind: maybe it could be interesting to have the 
status of an interface in the reply. So basically if netsock is >= 0 or not. 
Not sure how to deal with the IPv4 mcast code. Most likely just by using 
netsock_mcast and indicator.

Kind regards,
	Sven
--nextPart9120863.S1E0kk7kuN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmHSvUMACgkQXYcKB8Em
e0ZNDA//SdlyWDnlwUshUNkO6kJC2B9rX0N4dDa0n2gOzJeR4agQdww/isouatsi
+gdIIZofuq89gXFxOa10kaq+Bk/ZK8BPszMPbtH5EJlbQG9BaIjJAfJWLRaHdscd
T3kUsWGuhthMmZn/ZWehNODLNUK+phYeW9oWWKRc6NC/2hKnpUvDIOVDG8JQW8hg
AFRm+Z8BH+EC3fEogBTeWljFu4CUOcT+pGVZ0yqYhe1HlMjogCtz40hb0zAim2VB
69yBSxjvtVYE9qkXdWgzjZVlH1H7GNi4qNdwqtEJF/tN5ZzL3ibDh9OVBWCZPb01
6e0mROhz/CpNKt7g6Bk8zdHEexNzaR3PtYSy+liu2bCtoPK1sPX6Ald2R/oNol1M
UJmcwRHG7NewnOpR1thQWS36xeozi76SJRyZjFc86HKGlL4Z0GZLF027sxyAsrzB
yCgyt36zXUxhhbt293JgPq5YJS96mYkiSyt6XE3nOQFmlHvnrw7/E8uZoa95CbS5
1VIdScIFbJd/Wc7sn+VFFX9flI8RGCnAZiwONy5bU5R+IkJxCfedQQpDy5p4g/1C
SamUfu0R7hW3Mzk2N61MW3do2G0ec3wkX7lwaFMAg5QtHNQCGkA6H3IxP84CugOH
verKn3pbXzPvPKEzBA6fuzCTd3SnuzZABIMS+RY31yJkOyjMnG0=
=JJLP
-----END PGP SIGNATURE-----

--nextPart9120863.S1E0kk7kuN--


