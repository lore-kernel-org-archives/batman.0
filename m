Return-Path: <gmazzurco89@gmail.com>
Sender: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Message-ID: <50944FF6.5070504@eigenlab.org>
Date: Fri, 02 Nov 2012 23:57:58 +0100
From: Gioacchino Mazzurco <gio@eigenlab.org>
MIME-Version: 1.0
References: <CAHD-aqLcsciDBA=4D3ZH0yP4WEYsgY7BhZ+3NFmnm4vQF_apmw@mail.gmail.com>
In-Reply-To: <CAHD-aqLcsciDBA=4D3ZH0yP4WEYsgY7BhZ+3NFmnm4vQF_apmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] A batman-adv success story
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

In Ninux Pisa we use batman-adv too with similar results!

eccept for this:

On 11/02/12 22:21, Gui Iribarren wrote:
> As it is today, you can't put 2 ipv6 gateways doing SLAAC in the same
> batman-adv cloud.

This sentence is a little misleading, it is not true you cannot do it,
you can but you just receive multiple route announcement that may be not
optimal but it is not problematic in most cases

On 11/02/12 22:21, Gui Iribarren wrote:
> Hey folks,
> Marek once asked on the IRC channel about our project,
> Mitar also asked for a proper introduction [0]
> And i get the feeling it would be nice to describe a small real world
> batman-adv implementation
> i've seen many times mails from people doing simulations or whatnot, to
> decide if batman-adv works as expected... and i guess they would appreciate
> reading about live use cases :)
> 
> So here it goes,
> 
> this thing started back in february 2012 [1] in Cordoba with Nico Echaniz
> et al
> 
> Shortly after DeltaLibre followed, replicating the model. From the very
> beginning we aimed at building the cheapest possible, performant
> multi-radio mesh node.
> 
> Ten months later, although there's still room for improvement, we are very
> happy looking back at the path that took us here :). Starting with the
> decision of choosing batman-adv, as explained in a spanish reply to Esteban
> Municio [2]
> 
> ===translation===
> 2012/9/10 Esteban Municio <emunicio en gmail.com>:
>> Was there any reason why you chose batman-adv over other protocol?
> Layer 2! no subnet configuration, "Just Works", it's easy to forget
> batman-adv
> is down there doing all the magic - A routing protocol that stays out of
> your way, is priceless.
> 
>> which were your main issues working with batman-adv?
> With batman-adv... almost none :)
> Main difficulties until now were on phy level (interference) or layer 1
> (hardware, drivers, firmware)
> 
> With batman-adv, we bumped into 2 or 3 bugs, reported to the mailing list,
> and received prompt solutions
> thanks to the daily work that the developers put into it.
> Last version 2012.3.0 includes all those fixes.
> 
> Pending issues are a strange behaviour where avahi packets are lost (can't
> assure batman-adv is the culprit)
> and an open ticket[3] about adding RAs mangling support to gw_mode,
> extending the DHCPv4 segmentation logic to SLAAC networks as well.
> As it is today, you can't put 2 ipv6 gateways doing SLAAC in the same
> batman-adv cloud.
> So far is not a showstopper for us, but we would love to be able to do that.
> ======
> 
> (for the record, that "strange avahi behaviour" seems solved with the CRC
> broadcast fixes in 2012.4.0 :D)
> 
> Some numbers: with the hardware[4] we are using (TL-MR3220 and WN722N),
> throughput in point-to-point links maxes out at 30 or 40mbps respectively,
> on MISO HT20
> With our dual-radio mesh nodes, we can sustain that transfer speed over 3
> hops, using channels 1 and 11 for alternating interfaces.
> Given the small size of the networks, a longer path is currently not
> possible, but when using a single radio, or interfering channels, that same
> path throughput quickly drops to about 6 mbps, as predicted by the models.
> This is not news for many, but as said in the beginning of the email, i see
> some folks "doubting" about the performance, or overhead, of batman-adv...
> In tests we made, over a single hop (that is, from A to C as in  A --> B
> --> C where point to point links reach ~30mbps), static routing reached
> 30mbps +/- 0.5mbps, and using batman-adv 29mbps +/- 0.5mbps
> A real bargain for the bat-benefits :)
> 
> (i'm really sorry i can't provide supporting charts and logs ATM, collecting
> them would delay this email even further, and it's been months already
> since I have this email forgotten in drafts folder :( )
> 
> To easily share, publish and keep track of config tweaks between our
> networks we setup a hg repo [5][6]
> and eventually added bat-graphs for some basic context. [7]
> That can't possibly be maintained at a larger scale, but still proves
> incredibly useful at research stages.
> It has been used by an independent group (Gabriel Tolon et al) to
> compatibilize its equipments with DeltaLibre network at their lab, then
> bring the nodes into the region, plug, and Just Worked, with little
> intervention on our part.
> 
> We pull the overlays with a bash hack named ruci[8]
> and use that too to push and stage experimental configs to the whole
> network without fear of locking us out because of a config mistake or typo.
> 
> (i'm aware this has been addressed by multiple solutions, but ruci was born
> back in february while we didn't have a decent internet access to research
> previous art - we have changed tactics since then, trying to integrate with
> the rest of the movements :) )
> 
> Finally, some obligatory pictures [9] of representative (..?) nodes
> last months' smokeping stats [10] and cacti [11]
> 
> and as a bonus, a crude video [12] filmed by Al Cano from guifi.net while
> visiting DeltaLibre back in May, enjoying seamless roaming along 6 nodes
> while literally navigating through the batman-adv mesh :)
> 
> In QuintanaLibre (Quintana is a mountains *small* town with <500 habitants)
> you can spot kids using their OLPC netbooks while sitting in a
> (resting) horse' back.
> With almost no cellphone signal nor landlines whatsoever, you can imagine
> how much they appreciate having a WCN at their town.
> 
> All this can't possibly express how grateful we are with you batpeople, but
> I hope it gives a glimpse ;)
> Cheers!
> 
> Gui
> 
> [0]: http://wlan-si.net/lists/arc/nodewatcher/2012-08/msg00005.html
> [1]: http://blog.altermundi.net/article/timeline-february-september-2012/
> [2]:
> http://listas.altermundi.net/pipermail/redeslibres/2012-October/001438.html
> [3]: http://www.open-mesh.org/issues/159
> [4]: http://docs.altermundi.net/MiniMaxi/Hardware
> [5]: https://bitbucket.org/guidoi/deltalibre-configs
> [6]: https://bitbucket.org/nicoechaniz/quintanalibre-configs
> [7]:
> https://bitbucket.org/guidoi/deltalibre-configs/src/tip/files/deltalibre_2012-08-14.svg
> [8]: https://bitbucket.org/guidoi/ruci/
> [9]: http://blog.altermundi.net/article/algunas-imagenes-de-deltalibre/
> [10]: http://ping.deltalibre.org.ar/
> [11]: http://graficas.deltalibre.org.ar/
> [12]:
> http://es.wiki.guifi.net/wiki/Archivo:Paseo_en_canoa_conectado_a_BATMAN-advanced_por_Delta_Libre.ogv
