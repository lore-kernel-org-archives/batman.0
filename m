From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv debian announcement
Date: Mon, 17 Nov 2008 10:08:38 +0800
References: <200811170004.23285.lindner_marek@yahoo.de>
	<200811170137.31341.lindner_marek@yahoo.de>
	<5635aa0d0811161221k6b42efdcyd344e521d1cc65f1@mail.gmail.com>
In-Reply-To: <5635aa0d0811161221k6b42efdcyd344e521d1cc65f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811171008.39796.lindner_marek@yahoo.de>
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

On Monday 17 November 2008 04:21:22 Outback Dingo wrote:
> whats tells batmand-advanced its actually an internet gateway ???

Here is what Simon wrote some mails ago:  :-)

You should know that batman-adv does not have special gateway support
like the layer 3 batman versions. It can be considered as a big switch
where every node is one virtual hop away. You can therefore configure it
like your home LAN: install DHCP on your router, and that's it. If you
have multiple gateways, you might consider multiple DHCP servers, or 
something else ... depending on your scenario. :)


