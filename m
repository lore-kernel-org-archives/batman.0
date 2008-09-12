From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 12 Sep 2008 10:41:33 +0800
References: <8c906fa50809100941y79bc2011nd234780ad7b5cd0@mail.gmail.com>
	<200809111101.31420.lindner_marek@yahoo.de>
	<8c906fa50809111518y799f5a29me41a8ece69f47ae4@mail.gmail.com>
In-Reply-To: <8c906fa50809111518y799f5a29me41a8ece69f47ae4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809121041.33187.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] BATGAT
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

On Friday, 12. September 2008 06:18:58 Gustavo Lindberg wrote:
> B.A.T.M.A.N. 0.3-beta (compatibility version 5)

It seems you are using an older version of the daemon together with the kernel 
module. "0.3-beta" may not be compatible with the latest kernel module.


> [        80] Error - can't set IFFLAGS for gate0: Cannot assign requested
> address
> [        80] Error - can't set IFFLAGS for gate0: Cannot assign requested
> address

It does not crash here but exits because it can't set the IP address. 

Please update to the latest versions first.

Greetings,
Marek
