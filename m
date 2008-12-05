Message-ID: <4939136F.9000800@web.de>
Date: Fri, 05 Dec 2008 13:41:35 +0200
From: "Chris W." <chris-wy@web.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] 0.3.1 rv1152 - some test results
References: <492DDC20.7090900@web.de>
	<20081128205145.GB25072@pandem0nium>	<4930713D.40809@web.de>
	<200812011230.01187.lindner_marek@yahoo.de>
In-Reply-To: <200812011230.01187.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: chris-wy@web.de
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

Hello there,

meanwhile with  rv 1172  the previously mentioned issues concerning 
wrong or double routing entries are solved: nodes and announced networks 
are reachable on broadcom and on atheros devices and the gateway tunnel 
works as described when NAT'ed.
Great, thanx !

The sip test with NAT is still to come.

best regards,
Chris


Marek Lindner schrieb:
> On Saturday 29 November 2008 06:31:25 Chris W. wrote:
>> Uh, this would mean double NAT in the network, sip phones don't like it.
> 
> I overlooked that comment thats why my answer comes a bit late:
> 
> Are you sure that the batman setup is a problem for SIP ? I'm definitely not 
> the SIP expert but I don't think it is a problem (correct me if I'm wrong).
> 
> The normal double NAT setup looks like this:
> 
> NET_A -> NET_B -> Internet
> 
> SIP & STUN get in trouble here.
> 
> 
> In the batman network it looks a bit different:
> 
> NET_A -> NET_B -> NET_A -> Internet
> 
> The second NAT is used for internal transport only. I guess STUN will not 
> notice that there is the second network in between. Could you verify that ?
> 
> Regards,
> Marek
> 
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> 
