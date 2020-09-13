Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Sun, 13 Sep 2020 23:22:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] batctl: tcpdump: Fix endianness in ICMPv6 Echo
 Request/Reply parsing
Message-ID: <20200913222242.GB11498@makrotopia.org>
References: <20200913213019.4250-1-linus.luessing@c0d3.blue>
 <58865265-3048-1fa1-d1f2-8a5b6a0f0487@txtfile.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58865265-3048-1fa1-d1f2-8a5b6a0f0487@txtfile.eu>
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Mon, Sep 14, 2020 at 12:07:41AM +0200, txt.file@txtfile.eu wrote:
> I wonder about the "_might_ need a conversion" as most cpu architecture=
s run
> little endian. Especially x86.
>=20
> Wouldn't it be broken since years if it needed big =E2=86=92 little con=
version?

The tcpdump output for IPv6 echo request/reply was for sure broken for
years on little endian targets.
Note that most old-school router platforms are big endian, hence it
worked well on the common ubiquiti and tp-link devices.

>=20
> kind regards
> txt.file
>=20
> On 9/13/20 11:30 PM, Linus L=C3=BCssing wrote:
> > The ICMPv6 Echo Request/Reply sequence number and id as well as the
> > IPv6 header length are two byte long fields and therefore might need =
a
> > conversion on a little endian system. Otherwise the output will be
> > broken on such a machine.
> >=20
> > Fixes: 35b37756f4a3 ("add IPv6 support to tcpdump parser")
> > Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> > ---
> >   tcpdump.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/tcpdump.c b/tcpdump.c
> > index db93681..b9edc20 100644
> > --- a/tcpdump.c
> > +++ b/tcpdump.c
> > @@ -589,13 +589,15 @@ static void dump_ipv6(unsigned char *packet_buf=
f, ssize_t buff_len,
> >   			break;
> >   		case ICMP6_ECHO_REQUEST:
> >   			printf(" echo request, id: %d, seq: %d, length: %hu\n",
> > -			       icmphdr->icmp6_id, icmphdr->icmp6_seq,
> > -			       iphdr->ip6_plen);
> > +			       ntohs(icmphdr->icmp6_id),
> > +			       ntohs(icmphdr->icmp6_seq),
> > +			       ntohs(iphdr->ip6_plen));
> >   			break;
> >   		case ICMP6_ECHO_REPLY:
> >   			printf(" echo reply, id: %d, seq: %d, length: %hu\n",
> > -			       icmphdr->icmp6_id, icmphdr->icmp6_seq,
> > -			       iphdr->ip6_plen);
> > +			       ntohs(icmphdr->icmp6_id),
> > +			       ntohs(icmphdr->icmp6_seq),
> > +			       ntohs(iphdr->ip6_plen));
> >   			break;
> >   		case ICMP6_TIME_EXCEEDED:
> >   			printf(" time exceeded in-transit, length %zu\n",
> >=20
