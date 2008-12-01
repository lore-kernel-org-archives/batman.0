From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3.1 rv1152 - some test results
Date: Mon, 1 Dec 2008 12:30:00 +0800
References: <492DDC20.7090900@web.de> <20081128205145.GB25072@pandem0nium>
	<4930713D.40809@web.de>
In-Reply-To: <4930713D.40809@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812011230.01187.lindner_marek@yahoo.de>
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

On Saturday 29 November 2008 06:31:25 Chris W. wrote:
> Uh, this would mean double NAT in the network, sip phones don't like it.

I overlooked that comment thats why my answer comes a bit late:

Are you sure that the batman setup is a problem for SIP ? I'm definitely not 
the SIP expert but I don't think it is a problem (correct me if I'm wrong).

The normal double NAT setup looks like this:

NET_A -> NET_B -> Internet

SIP & STUN get in trouble here.


In the batman network it looks a bit different:

NET_A -> NET_B -> NET_A -> Internet

The second NAT is used for internal transport only. I guess STUN will not 
notice that there is the second network in between. Could you verify that ?

Regards,
Marek

