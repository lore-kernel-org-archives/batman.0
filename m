Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 03 Jul 2015 13:40:11 +0200
Message-ID: <1467513.dHSoo3DKj0@bentobox>
In-Reply-To: <2779160.PvUSbAU1eu@voltaire>
References: <1435811430-6949-1-git-send-email-linus.luessing@c0d3.blue>
 <2779160.PvUSbAU1eu@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7041126.OHNRTSd7D2";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix broken capability
	checks
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--nextPart7041126.OHNRTSd7D2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 03 July 2015 19:13:02 Marek Lindner wrote:
> > @@ -299,10 +299,10 @@ struct batadv_orig_node {
> >   *  (= orig node announces a tvlv of type BATADV_TVLV_MCAST)
> >   */
> >  enum batadv_orig_capabilities {
> > -	BATADV_ORIG_CAPA_HAS_DAT = BIT(0),
> > -	BATADV_ORIG_CAPA_HAS_NC = BIT(1),
> > -	BATADV_ORIG_CAPA_HAS_TT = BIT(2),
> > -	BATADV_ORIG_CAPA_HAS_MCAST = BIT(3),
> > +	BATADV_ORIG_CAPA_HAS_DAT,
> > +	BATADV_ORIG_CAPA_HAS_NC,
> > +	BATADV_ORIG_CAPA_HAS_TT,
> > +	BATADV_ORIG_CAPA_HAS_MCAST,
> >  };
> 
> Do we need an initialization of the first element or can we rely on the 
> compiler to start with 0 ?

Just discussed this with Marek on IRC. We came to the conclusion that ANSI C 
"3.5.2.2 Enumeration specifiers" is enforcing a 0 as first entry (when not 
specified otherwise):

    If the first enumerator has no = , the value of
    its enumeration constant is 0.  Each subsequent enumerator with no =
    defines its enumeration constant as the value of the constant
    expression obtained by adding 1 to the value of the previous
    enumeration constant.

But the code should maybe cleaned up to either use "= 0" everywhere or nowhere 
in the internal representations.

Places where = 0 is used:

 * net/batman-adv/bat_iv_ogm.c:enum batadv_dup_status
 * net/batman-adv/main.h:enum batadv_uev_action (maybe not internal?)
 * net/batman-adv/main.h:enum batadv_uev_type (maybe not internal?)
 * net/batman-adv/types.h:enum batadv_dhcp_recipient

Not used:

 * net/batman-adv/gateway_common.h:enum batadv_gw_modes
 * net/batman-adv/gateway_common.h:enum batadv_bandwidth_units
 * net/batman-adv/hard-interface.h:enum batadv_hard_if_state
 * net/batman-adv/hard-interface.h:enum batadv_hard_if_cleanup
 * net/batman-adv/main.h:enum batadv_mesh_state
 * net/batman-adv/multicast.h:enum batadv_forw_mode
 * net/batman-adv/types.h:enum batadv_counters

I don't count packet.h because this is clearly not internal and the packet 
definitions should not be accidentally changed just because the enum constant 
order is changed.

Kind regards,
	Sven
--nextPart7041126.OHNRTSd7D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVlnSeAAoJEF2HCgfBJntG+g0P/iGo+wFICwdDWw5oj5c/85cs
qG7RmnRjx+E1aX1Xv9gAjZiwVS7HKAR62yk9/FTVpyhIbCskoN++0Tyd2zOQQ9FD
plIstmcXwIyNE3yHrcH2uLrrJLkABxruYCldx/WO3GlEG68RSxTlkchX4bTNlB3J
msGKF3cgTGlk0WfnNKiuJ8936jRh+uOx4fpHDid0mG2Sd0N6FdYei9uo5FoXJ0U0
LFKPjiFtoYu4y3M3A942AJRmmzNomwg/u0IrJX+PQHBfnyrnGhD29xEydhIbxnpx
RBYG4QVpiXBtbhrHY4C0F/xwiPRzcvxCAWfTN5YyZGswPVT62l4KS9sePA4nbsCj
AQK7z2VFkMXTdEzxv9fjSPKyrZiyqxzFT4v5Majc5cbQKrKYDNmRPib7axiwvqNi
TgR3sLJTYi/tfSk2aee/zKr8ZmpjcwWUjY8ckEIM87mE494/KRh5xJ/DeheD4+SW
H9mWRn1+444PFZRpZWmMrW/NfV8bTAOdCjJXRU/RPHYDJAXzFsChcV0FnwEuayQz
cgPQlvSm59ia0vPL0LzQQ1WVp9/0cPbQ3WWPK0FObx4euhlPB7aFBuLjTKAeM7j3
jBYkn0g0sFEkDnSpblVvaHS9QlBEhuYoor7z7H2l0sPK3lOJuovuy1Vnn5dRn6MD
HX75/kz0hgOGpkI30hwS
=ufNd
-----END PGP SIGNATURE-----

--nextPart7041126.OHNRTSd7D2--

