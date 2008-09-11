From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 11 Sep 2008 11:01:31 +0800
References: <8c906fa50809100941y79bc2011nd234780ad7b5cd0@mail.gmail.com>
	<20080910193801.GA10777@pandem0nium>
	<8c906fa50809101400i4c30cff5geb16998e11d7c607@mail.gmail.com>
In-Reply-To: <8c906fa50809101400i4c30cff5geb16998e11d7c607@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809111101.31420.lindner_marek@yahoo.de>
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

On Thursday, 11. September 2008 05:00:59 Gustavo Lindberg wrote:
> I am experimenting very frustrating issues with batgat. Currently i am
> testing the last trunk of kamikaze on ubiquity NS2. Batmand dies quietly
> with batgat loaded. I will prove the last kamikaze on two NS2 without
> batgat and inform the bug  if this error happen again.

I think it would be intersting to find out why batmand dies. May be you could 
produce a core dump ?
Indeed, we have a problem if the batman daemon dies without telling the 
module. What about adding a keep alive + timeout in the module ?

Greetings,
Marek
