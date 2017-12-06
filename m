Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Wed, 06 Dec 2017 11:26:49 +0100
Message-ID: <1932095.qaFFlVjcYD@bentobox>
In-Reply-To: <CALx6S34QfkvbGqrSahQ17upSPDjNaHnf4wsxk90gXgR2dW_D8A@mail.gmail.com>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
 <20171205143514.4441-7-sven.eckelmann@openmesh.com>
 <CALx6S34QfkvbGqrSahQ17upSPDjNaHnf4wsxk90gXgR2dW_D8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1519922.K4L3v8FpD6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 6/6] flow_dissector: Parse batman-adv
 unicast headers
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Tom Herbert <tom@herbertland.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@mellanox.com>, Eric Dumazet <edumazet@google.com>, LKML <linux-kernel@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org

--nextPart1519922.K4L3v8FpD6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 5. Dezember 2017 09:19:45 CET Tom Herbert wrote:
[...]
> Switch statements with cases having many LOC is hard to read and
> __skb_flow_dissect is aleady quite convoluted to begin with.
> 
> I suggest putting this in a static function similar to how MPLS and
> GRE are handled.

Thanks for the feedback.

I was not sure whether "inline" or an extra function would be preferred. I've 
then decided to implement it like most of the other protocols. But since an 
extra function is the preferred method for handling new protos, I will move it 
to an extra function.

The change can already be found in
 https://git.open-mesh.org/linux-merge.git/shortlog/refs/heads/ecsv/flowdissector

I also saw that you've introduced in
commit 823b96939578 ("flow_dissector: Add control/reporting of encapsulation") 
a flag to stop dissecting when something encapsulated was detected. It is not 
100% clear to me when the  FLOW_DIS_ENCAPSULATION should be set and 
FLOW_DISSECTOR_F_STOP_AT_ENCAP be checked. Only when there is IP/eth in IP 
(like in the two examples from the commit message) or also when there is a 
ethernet header, followed by batman-adv unicast header and again followed by 
an ethernet header?

Right now, the flag FLOW_DISSECTOR_F_STOP_AT_ENCAP is only used by 
fib_multipath_hash - so it doesn't really help me to understand it. But the 
FLOW_DIS_ENCAPSULATION is checked by drivers/net/ethernet/broadcom/bnxt/bnxt.c
to set it in a special tunnel_type (anytunnel) mode for IPv4/IPv6 packets. So 
my (wild) guess right now is that these flags should only be used/checked when 
handling encapsulation inside IPv4/IPv6 packets. But maybe you can correct me 
here.

Kind regards,
	Sven

--nextPart1519922.K4L3v8FpD6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlonxekACgkQXYcKB8Em
e0aoyw//ecriucCyOveLDUGzwPA1aCG7vsOQ5Ob8sf4JznwFDAf66P4/HyZ490rt
c296nbBRw50oxUUs7dPgFXmcxOEdfNdZhWyfEm2pC/xqhyEKrc7V+1h231Ye4kr+
X3FqsqrXbL4o5fDJMLgS8cTLdummo75VB1y6uh0JwnP+qCL7ge9UPgf3yrMjJcHo
47ELpFKtaOgOtGKasH3VC1rs9kWG0GQKV+fCh5TlE174H1qnRI7xpmvfzDraDph8
dI5h/NyqUARThQphTdCimteH/nymvt6xjKudo0BFAnjNxB0RduHMhqRxkLnj0djf
8Y2Mr2LuNCAN8NjrZKHPG9O+i+k8rxFS2NPb2LBnpST/bJoRtkuYnbBTPaD7OBeF
Cv7HSX5UlYUswylyRkZvAv8JVEP3q5xFaSkB1abp+2/Tc3yhe/05+KpK8L/SCx+X
HE+mJ9euMtoXG1SqlGYRxzQxvDRNy6ff6Pzjkt4FX41rK6HSidwSXgxo4PkzJVTd
47wdruSBWapd96ZA5OiOxEh73+dgtkp+8oZMcHm1fv11IMkixcozHTIWG71rKueQ
jiIHFXctN0/WEWY44l8OM4DVxBh1VkETxMiPrLH5uMrUkqVJhPm7z7Pua412pnBQ
nOkaYfy+VA2r8dIWKgBE/Yq1Ljj29BNnmkXGuiaW/734OkvgYLw=
=6ePW
-----END PGP SIGNATURE-----

--nextPart1519922.K4L3v8FpD6--

