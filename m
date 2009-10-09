Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 9 Oct 2009 23:42:50 +0800
References: <20091008204536.324000@gmx.net>
In-Reply-To: <20091008204536.324000@gmx.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200910092342.50653.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman and encryption
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hey,

> I'm experimenting with batman right now and would like to know, if there is
>  a way to implement it with Openswan or another encrypting/tunneling
>  software (OpenSSL?). I'm testing batman on a couple of WRT54GL. I'm
>  interested in not allowing everybody to connect to my router only by
>  knowing the BSSID.

you can combine batman with any known encryption technology such as 
IPSec/WPA/VPNs (just to name a few). As these encryption methods operate on 
another layer batman does not take notice, hence does not care what you use.

Regards,
Marek
