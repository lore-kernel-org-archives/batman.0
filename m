Message-ID: <47190119.3080607@ddmesh.de>
Date: Fri, 19 Oct 2007 21:10:17 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] no gateway / tun interface / default route
References: <4717BE98.2010206@ddmesh.de>	<200710191251.35340.lindner_marek@yahoo.de>	<4718E6AC.9020100@ddmesh.de>
	<200710191952.10376.lindner_marek@yahoo.de>
In-Reply-To: <200710191952.10376.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-15
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

Hi,

thanks for you quick answer and the explaination how the gateway-ing
is working.

>> The second problem is that the documentation speeks about three routing
>> tables 65,66,67 where table 67 is used for adding the gateway routes.
>> I haven't added a rule to this table 68 (see ip rule below).
>>
>> is the table 67 for?
>> Are there now four routing tables?
> 
> Which documentation ? We should fix that.

Please see bmx.pdf of batman-experimental chapter 4.1.2
and page 27 almost at the end of this page.
(https://www.open-mesh.net/batman/doc/BMX/bmx.pdf/view)
Also found at the html version at "Customizing the used routing table and priority rules"
and  batmand --dangerous -H

I'm using experimental revision 724.

Bye Stephan
