Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 6 Jul 2012 00:04:49 +0200
References: <CAHD-aqJcFYHCEMh66JaR3a_AbkKmNtAkvZ2s6j8Szd=xmvh8jg@mail.gmail.com>
	<1341427099-12368-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1341427099-12368-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201207060004.49919.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint-v2] batman-adv: check incoming
	packet type for bla
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wednesday, July 04, 2012 20:38:19 Simon Wunderlich wrote:
> If the gateway functionality is used, some broadcast packets (DHCP
> requests) may be transmitted as unicast packets. As the bridge loop
> avoidance code now only considers the payload Ethernet destination,
> it may drop the DHCP request for clients which are claimed by other
> backbone gateways, because it falsely infers from the broadcast address
> that the right backbone gateway should havehandled the broadcast.
> 
> Fix this by checking and delegating the batman-adv packet type used
> for transmission.
> 
> Reported-by: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Applied in revision e324701.

Thanks,
Marek
