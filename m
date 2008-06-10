Message-ID: <484E9ABE.8010808@gmx.net>
Date: Tue, 10 Jun 2008 17:16:14 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Batman & multiple radios
References: <1213107210.7872.15.camel@damian-x31.damian.org>
In-Reply-To: <1213107210.7872.15.camel@damian-x31.damian.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi -

B.A.T.M.A.N. supports multiple interfaces - so you may add more than one WiFi card to your systems and run batman on every interface that you like. Performance wise you should use different non-overlapping channels with different ESSIDs for your cards. You may use omnidirectional antennas, sectors or directionals. The latter two options will give you a planned infrastructure, where you have to do the channel planning (cellular infrastructure). There is no point in aiming directionals against each other while their interfaces work on different channels... You may still benefit from batman in such a planned network, because it will save you editing routing tables by hand.

If you use omnis (say two interface per device on channel 1 and 13) and the network is idle the routing may utilize just one channel. But as soon as there is traffic starting to saturate the links, the protocol should start using different channels. There is however no dedicated mechanism to coordinate the re-use of channels. Therefore Batman will need traffic in order to channel adaption. However this is AFAIK untested, and we'd love to hear about your results.

cu elektra




> I am seriously looking at using B.A.T.M.A.N. to drive a mesh network in
> a small town in Australia. One of the hassles with typical mesh networks
> is the way the performance drops off when you have many hops, due to the
> radio having to keep switching between send and receive. The standard
> way to get around this appears to be to use multiple radios.
>
> How is this done with batman? Is it a case of having multiple
> directional aerials - such that one radio can be receiving from one
> direction and another can be sending to the next node up the chain? It
> makes sense to put the local traffic (e.g. running a local AP) on a
> separate radio from the "back haul".
>
> Does anyone have any experience with sort of layout? The main driver
> here is performance rather than coverage.
>
> Damian 
>   

