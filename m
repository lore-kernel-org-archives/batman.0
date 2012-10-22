Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
From: Gui Iribarren <gui@altermundi.net>
Date: Mon, 22 Oct 2012 18:21:00 -0300
Message-ID: <CAHD-aqJFHc+YbrYTL53hX5G=mvDLrDKSn6_JfNQzEvPPU50SRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Web-based Visualisation Tool
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
To: steve@villagetelco.org, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, interop-dev@lists.funkfeuer.at, paul@servalproject.org, nodewatcher@wlan-si.net

A few weeks ago, after reviewing nodeshot, nodewatcher, and others,
NicoEchaniz decided to start AlterMap, which literally means "yet
another map"

the idea, though, is to make it as flexible as possible, so that it
can be adopted / backported to existing networks. Very much like the
interop-dev effort, but skipping the name voting part :)

the outstanding difference with current map solutions, and main
appeal, is that it mixes CouchDB, JSON, Backbone and Leaflet , so:
 * the database is schema-less, (in order to accomodate the
irreconcilably different db schemas from guifi.net, ninux, athens,
wlan-si...)
 * it can be implemented as a CouchDB applet, so the frontend can be
served entirely from a uhttpd running on openwrt, serving simple js.
 * couchDb implements native synchronization, which enables from the
start the possibility of downloading a copy of the db to a cellphone,
creating a node offline while "in the field", and syncing it back
afterwards,  a feature the guys at guifi.net are currently trying to
resolve.
 * another possibility is syncing *between* different networks, so
that for example ninux pisa can have its local couchDb where it
maintains pisa' nodes, and syncs two-way with ninux rome using native
couchDb support.
 * an extreme possibility of the above point, would be having a
frontend to a *world* map of all WCN nodes. The schemas of each
network would be different, so not every bit of information would be
displayed in that frontend, but at least name and gps location could
easily be aggregated.
 * as communication is done in JSON, current map implementations don't
need to be abandoned all of a sudden ; each network could code a
simple middleware that translates JSON between its current solution
and CouchDB, and make the transition smooth.
 * We started it with a batman-adv compatible-map idea in mind, but
again, as it is JSON, a script simply turns batctl output into JSON,
so any protocol can easily be scripted to talk JSON as well. (in
comparison, Nodeshot needs to make batman-adv output look like OLSR
format, instead of a "neutral" notation like JSON.)
 * Leaflet is actively developed, small, and already offers
touchscreen features for mobiles.
 * there's already also crazy ajax that enables near-realtime
visualization of data as it gets updated from any data-source. It
might sound far-fetched, but the map could aid mesh node positioning
by giving visual feedback on complex data such as multiple links as is
the case with neighbours on IBSS clouds.

Work so far is being done on
https://colectivo.altermundi.net/projects/altermap/wiki

almost all of the magic is done by CouchDB, etc, so the actual code is
a bunch of js, mostly glueing together "the shoulders of giants" ;)

What do you people think?

Paul,
Do you think this could have a positive interaction with Serval Maps?
I see these items in the roadmap:
 * Share mapsforge data via Rhizome
 * Explore options for export of geographic information to other
systems as required
maybe these could be leveraged by using couchDB and JSON?

On Wed, Oct 17, 2012 at 8:54 PM, Steve Song <steve@villagetelco.org> wrote:
> On 17 October 2012 18:45, "Linus L=C3=BCssing" <linus.luessing@web.de> wr=
ote:
>>
>>> Gesendet: Mittwoch, 17. Oktober 2012 um 21:44 Uhr
>>> Von: "Steve Song" <steve@villagetelco.org>
>>> An: b.a.t.m.a.n@lists.open-mesh.org
>>> Betreff: [B.A.T.M.A.N.] Web-based Visualisation Tool of Choice for batm=
an-adv?
>>>
>>> Hi all,
>>>
>>> Is there an obvious choice for web-based visualisation of batman-adv
>>> networks?  We currently use a custom product (SPUD -
>>> http://dev.villagetelco.org/trac/browser/spud/trunk/INSTALL) built
>>> specifically for Village Telco but would prefer to join our efforts to
>>> a broader community-based effort.  I am aware of
>>>
>>> Nodewatcher
>>> http://nodewatcher.readthedocs.org/en/latest/installation.html
>>> and
>>> Nodeshot
>>> http://wiki.ninux.org/InstallNodeshot
>>>
>>> but both of these take a little adapting to batman-adv.  Is there
>>> anything out there that has been developed specifically for
>>> batman-adv?
>>
>> For our local Freifunk community here in L=C3=BCbeck we are currently us=
ing a
>> home-brewed solution called 'ffmap-d3' developed by Nils Schneider
>> to visualize our batman-adv topology. Source code is available on github=
:
>>
>> http://tcatm.github.com/ffmap-d3/
>>
>> It is still quite new and still gets its regular tweaks, but this
>> page should already give you an idea about how it looks like, its curren=
t
>> features and general usability:
>>
>> http://holstentor.metameute.de/mesh/nodes.html
>>
>>
>> Not sure whether this is something you are looking for, but thought I'd
>> mention it anyway.
>>
>
> ffmap-d3 is quite beautifully done, very elegant rendering of nodes
> although we are looking for something more GIS-oriented.  Both are
> worth exploring though.  Thanks.
>
> Cheers... Steve
