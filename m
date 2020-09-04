Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: Is it possible to send all batman-adv traffic through http proxy
 cache?
References: <CA+RexfHNV+HY28OiuHKNy4Rn=MM4gxOU0xCiVG0z56dfnv_z6g@mail.gmail.com>
 <20200904184403.GA2391@otheros>
From: "A. James Lewis" <james@fsck.co.uk>
Message-ID: <c746bd54-37d3-cb62-a647-a07176289733@fsck.co.uk>
Date: Fri, 4 Sep 2020 20:03:24 +0100
MIME-Version: 1.0
In-Reply-To: <20200904184403.GA2391@otheros>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

You could set up a transparent proxy, in the route to the batman=20
gateway,,, you've have to look at the exact details of how the=20
routing/NAT is set up, but I'd bet you could do some pretty clever stuff:=
-

https://tldp.org/HOWTO/TransparentProxy.html

James


On 04/09/2020 19:44, Linus L=C3=BCssing wrote:
> Hi,
>
> On Fri, Aug 28, 2020 at 06:00:59PM -0400, Chuck Ritola wrote:
>> Is it possible to send all batman-adv ethernet traffic through an HTTP
>> proxy cache such as Squid?
> Not really, there are a bunch of headers too many for an HTTP
> caching proxy to work with batman-adv.
>
> I'm wondering, are HTTP caching proxies actually still useful these
> days where all major sides have switched to HTTPS?
>
>> Another consideration was ALFRED but it doesn't appear to be easily
>> integratable with existing software.
> Alfred is more useful for little bits of information, not really
> for complete packet streams.
>
>
> The "best" solution I could think of right now for limited uplink
> bandwidths is hosting content within your mesh network instead.
> Like setting up a Seafile or MediaGoblin, for instance.
>
> Or using P2P technologies, like Bittorrent. Although you might
> need to be careful with this particular one that it won't greedly
> occupy the rest of the bandwidth your uplink has left, if content is
> still mainly shared over the uplink and not within the mesh.
>
> Regards, Linus
--=20
*=E0=B8=84. =EF=BB=9D=E0=B8=84=E0=B9=93=D1=94=E0=B8=A3 =C9=AD=D1=94=E0=B8=
=AC=E0=B9=80=E0=B8=A3* (james@fsck.co.uk)
"Engineering does not require science. Science helps a lot but people
built perfectly good brick walls long before they knew why cement works."
