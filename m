From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Date: Wed, 7 May 2008 20:41:53 +0800
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
In-Reply-To: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805072041.54021.lindner_marek@yahoo.de>
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

> I have made a new version of the patch posted by acinonyx (rv502),
> for interfacing batmand with the zebra routing daemon. There are 2
> versions available: One for the latest svn (rv1060) and one for the
> stable 0.3 release. Take a look at:
>
> http://www.cslab.ece.ntua.gr/~chazapis/batman/

it looks good - thanks for your work. I would like to put your changes on 
open-mesh.net. Either linking to your webspace or copying your work on our 
server. What do you prefer ?


> What the patch does is:
> - Adds a flag "-z" to the batmand executable which may be used to
>    enable zebra communication and accepts as an argument the
>    path to the corresponding zebra unix-domain socket.
> - If zebra is enabled:
>    - No rules are added to the kernel.
>    - All UNICAST routes are sent to zebra.

Did you consider using the "--policy-routing-script" for this communication 
with zebra ? You could write an external program that gets the information 
from batman and relays them to zebra. Therefore, you would not need to patch 
every batman installation and would not have to change your patches every 
time when batman changes. By using this facility you can decide what routes 
are sent to zebra, what routes are added to the routing table and you don't 
need to worry about batman. This communication interface could also be used 
by other routing protocols without the need of reinventing the wheel over and 
over again.

Greetings,
Marek
