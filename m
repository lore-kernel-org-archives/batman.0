Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
References: <CA+RexfHNV+HY28OiuHKNy4Rn=MM4gxOU0xCiVG0z56dfnv_z6g@mail.gmail.com>
 <20200904184403.GA2391@otheros> <c746bd54-37d3-cb62-a647-a07176289733@fsck.co.uk>
In-Reply-To: <c746bd54-37d3-cb62-a647-a07176289733@fsck.co.uk>
From: Chuck Ritola <cjritola@gmail.com>
Date: Tue, 8 Sep 2020 11:47:02 -0400
Message-ID: <CA+RexfFSc=Vbx01utuo4gLqDKrYmU8yykGD7qR8p0XC7-V5+gQ@mail.gmail.com>
Subject: Re: Is it possible to send all batman-adv traffic through http proxy cache?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> I'm wondering, are HTTP caching proxies actually still useful these
days where all major sides have switched to HTTPS?
(Linus)
>You could set up a transparent proxy, in the route to the batman
gateway,,, you've have to look at the exact details of how the
routing/NAT is set up, but I'd bet you could do some pretty clever stuff:-
(James)

This would be mostly-mesh hosting with almost no uplink. We are
allowed to carefully gateway some internet content such as 44-block
IPs and maybe sites with 'safe' content such as NOAA. The choke point
is not the internet gateways like it would for a traditional 802.x
mesh but the speed of the hops themselves, as this involves VHF/UHF
with 20-1000 kilobit speeds to get 20-100mi hop lengths. Sometimes ghz
802.xx is used for last-mile, cities, etc. AREDN does a bit of this on
ghz but I wanted to go layer-2.

Amateur radio in the US is governed by FCC Part 97, which forbids
encrypted communications (the wording is 'intent to obscure its
meaning') so it pretty much has to be HTTP with no 'S'. A sidenote:
Authentication hashing is still ok. Sniffing traffic is encouraged.

The idea was to keep things simple by staying browser-based where
practical. Cacheable HTTP would be passively cached at every hop with
the storage for it. Even if part of the network got cratered there
would still be a 'ghost' of the content in the cache, and so long as
it was frequently accessed and had an unlimited age, said ghost could
propagate through the caches indefinitely.

I considered BitTorrent but it requires a tracking host, which means
centralization. Freenet looked interesting but by the time I remove
all of the encryption and obfuscation to make it legal for amateur
radio it ends up having similar functionality as per-hop cache proxy.

On Fri, Sep 4, 2020 at 3:04 PM A. James Lewis <james@fsck.co.uk> wrote:
>
> You could set up a transparent proxy, in the route to the batman
> gateway,,, you've have to look at the exact details of how the
> routing/NAT is set up, but I'd bet you could do some pretty clever stuff:=
-
>
> https://tldp.org/HOWTO/TransparentProxy.html
>
> James
>
>
> On 04/09/2020 19:44, Linus L=C3=BCssing wrote:
> > Hi,
> >
> > On Fri, Aug 28, 2020 at 06:00:59PM -0400, Chuck Ritola wrote:
> >> Is it possible to send all batman-adv ethernet traffic through an HTTP
> >> proxy cache such as Squid?
> > Not really, there are a bunch of headers too many for an HTTP
> > caching proxy to work with batman-adv.
> >
> > I'm wondering, are HTTP caching proxies actually still useful these
> > days where all major sides have switched to HTTPS?
> >
> >> Another consideration was ALFRED but it doesn't appear to be easily
> >> integratable with existing software.
> > Alfred is more useful for little bits of information, not really
> > for complete packet streams.
> >
> >
> > The "best" solution I could think of right now for limited uplink
> > bandwidths is hosting content within your mesh network instead.
> > Like setting up a Seafile or MediaGoblin, for instance.
> >
> > Or using P2P technologies, like Bittorrent. Although you might
> > need to be careful with this particular one that it won't greedly
> > occupy the rest of the bandwidth your uplink has left, if content is
> > still mainly shared over the uplink and not within the mesh.
> >
> > Regards, Linus
> --
> *=E0=B8=84. =EF=BB=9D=E0=B8=84=E0=B9=93=D1=94=E0=B8=A3 =C9=AD=D1=94=E0=B8=
=AC=E0=B9=80=E0=B8=A3* (james@fsck.co.uk)
> "Engineering does not require science. Science helps a lot but people
> built perfectly good brick walls long before they knew why cement works."
