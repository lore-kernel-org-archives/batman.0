From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 1 Apr 2009 10:28:57 +0800
References: <49D2300C.9010206@kait.de>
	<200904010215.44621.lindner_marek@yahoo.de>
	<5b8543210903311213n139e4323pa5e879c53fb42f04@mail.gmail.com>
In-Reply-To: <5b8543210903311213n139e4323pa5e879c53fb42f04@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904011028.58218.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman-adv nodes do not recieve OGMs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Wednesday 01 April 2009 03:13:01 Kai Timmer wrote:
> Actually i already tried that and it didn't change anything. And when
> that is really the problem, why is the module than even starting to
> send messages?

Athough the interface is down batman still runs internally to trigger events, 
timeouts, link quality updates, etc. That does not mean the packets go out 
although the logs might indicate packets were sent. You can easily verify 
whether the packets leave the system or not by using the battools or tcpdump. 

I agree with Simon: If you experience connection problems first make sure that 
ping & friends run smoothly. 

Regards,
Marek

