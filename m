Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH 3/3] alfred: properly initialize stack buffer before
 sending over unix socket
Date: Sat, 22 Jan 2022 01:41:36 +0100
Message-ID: <3612372.8DyAAORe3b@rousseau>
In-Reply-To: <2782676.din1RKh0Nb@sven-l14>
References: <10410848.OOsao9LFFs@rousseau>
 <20220112210506.3488775-3-mareklindner@neomailbox.ch>
 <2782676.din1RKh0Nb@sven-l14>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3789153.x0KFPWdY5J";
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

 
--nextPart3789153.x0KFPWdY5J
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Marek Lindner <mareklindner@neomailbox.ch>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Subject: Re: [PATCH 3/3] alfred: properly initialize stack buffer before sending over unix socket
Date: Sat, 22 Jan 2022 01:41:36 +0100
Message-ID: <3612372.8DyAAORe3b@rousseau>
In-Reply-To: <2782676.din1RKh0Nb@sven-l14>
References: <10410848.OOsao9LFFs@rousseau> <20220112210506.3488775-3-mareklindner@neomailbox.ch> <2782676.din1RKh0Nb@sven-l14>

On Friday, 21 January 2022 16:34:50 CET Sven Eckelmann wrote:
> > @@ -260,6 +262,7 @@ int alfred_client_change_interface(struct globals
> > *globals) }
> > 
> > len = sizeof(change_interface);
> > +       memset(&change_interface, 0, len);
> > 
> > change_interface.header.type = ALFRED_CHANGE_INTERFACE;
> > change_interface.header.version = ALFRED_VERSION;\
> 
> Same here.
> 
> > @@ -308,6 +311,7 @@ int alfred_client_change_bat_iface(struct globals
> > *globals) }
> > 
> > len = sizeof(change_bat_iface);
> > +       memset(&change_bat_iface, 0, len);
> > 
> > change_bat_iface.header.type = ALFRED_CHANGE_BAT_IFACE;
> > change_bat_iface.header.version = ALFRED_VERSION;
> 
> Same here.

The struct alfred_change_interface_v0 -> ifaces[IFNAMSIZ * 16] may be written 
to but not fully initialized. The interface name may be much shorter than the 
buffer holding it. Same applies struct alfred_change_bat_iface_v0 -> 
bat_iface[IFNAMSIZ] but to a lesser extent because the buffer is smaller.

This patch is based on your earlier observation that stack data may be leaked 
due to the lack of (complete) initialization.

You are correct that the structs struct alfred_request_v0 & 
alfred_modeswitch_v0 technically don't require initialization because all 
fields are set manually. I added those for completeness sake for the next 
person coming along copy & pasting the code (as I had done).

Kind regards,
Marek Lindner

--nextPart3789153.x0KFPWdY5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAmHrUsAACgkQU1VOj+62
HMDI0wf/URMpOphnkCDRntQ2D947UaIqsEpxqJeOlxno/bSkawmxzSXTQLr6TezO
qEY2d1IoEvx8beDhAIoaRLbTr6w6XcOOuk163Ecwsqu6ycyxK3yqAaAWGpLRoNCS
0HR29QHFcAShX4SJyC4W3ifqs8HPIXhn9YX9MPZmZiE2O7tCaG3esO2ZJd15xryX
SthgfauZBOdpVd2kLNkZWcT3N3jKq5s17ggZv+6o1+6/vLEpMBHVQCGY2OijCAU5
kJBYgOS9KWb5LFOukLUcMCZPPt9Htb53h1mQqJbGU5MUhLDw2PjtM14N+i/PUX7B
dCRrfdYriVNWqO8ksMY9CPvdSx4TlQ==
=Aehm
-----END PGP SIGNATURE-----

--nextPart3789153.x0KFPWdY5J--


