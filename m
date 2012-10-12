Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <5077A77B.3040803@altermundi.net>
Date: Fri, 12 Oct 2012 02:15:39 -0300
From: =?windows-1252?Q?NicoEch=E1niz?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <507798EE.80305@codigosur.org> <50779CA3.9070208@yahoo.de>
In-Reply-To: <50779CA3.9070208@yahoo.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv: ap mode with isolation enabled
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

On 10/12/12 01:29, Marek Lindner wrote:
> On 10/12/2012 12:13 PM, Nicol=E1s Ech=E1niz wrote:
>> Here's a blog post on this matter with related graphics:
>> http://blog.altermundi.net/article/batman-adv-ap-mode-with-isolation-ena=
bled/
>>
>>
>> Summary:
>> Infrastrucutre nodes tend to "confuse" batman-adv. Every client
>> connected to an ap will =93think=94 that it is directly connected to eve=
ry
>> other client, which creates a mess in potential hops selection.
>=20
> Guess you have to better explain your setup if you want others to
> understand. The phrase "the networks uses mixed adhoc and infrastructure
> modes" is not self-explanatory.

will do:

Our nodes are mostly TP-Link MR3220 or WR842N with a second wifi
interface connected by USB (usually WN722N).

These usb dongles use ath9k_htc which is stable and performant in
infrastructure mode, but not so in adhoc. So until our dear ordex :) can
get the time to squash whatever bugs are preventing the dongles from
performing well in adhoc, the networks are using both adhoc and
infrastructure. As a result, some links are adhoc and others are not.


The infrastructure links are the ones that show the behaviour described:
all clients of an AP believe they are neighbors, and isolation so far
seems to prevent this effectively.

The network in question covers 70% of a sparsely populated town and
currently has 15 active nodes with links ranging from 0.1 to 3Km, plus a
16Km link to a neighboring city.


The images in the link provided help ilustrate the differences observed
with and without isolation.


Is the setup clear enough now? or am I missing the point as to what is
unclear? Please ask whatever needs to be clarified.


cheers,
Nico.


