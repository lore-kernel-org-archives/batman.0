Message-ID: <a934d3f30801230049x78665caau3b4c657cb87521fe@mail.gmail.com>
Date: Wed, 23 Jan 2008 03:49:27 -0500
From: "Vinay Menon" <vinaymenon@gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman OpenWRT integration
In-Reply-To: <200801211920.30577.an.langer@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9300_32872952.1201078167943"
References: <200801211527.04600.lindner_marek@yahoo.de>
	<000001c85c3e$fd11d070$f7357150$@com>
	<200801211920.30577.an.langer@gmx.de>
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

------=_Part_9300_32872952.1201078167943
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

There is a typo in the batmand startup (init.d) script
the interface is refered as

interface=$(uci get batman.general.interface)
while it should be interface=$(uci get batmand.general.interface)
(ie. batman should be batmand)

similar is the case with the options too.

the uci command arguments are
uci get/set packagename.config_profile.option

Regards,
Vinay

------=_Part_9300_32872952.1201078167943
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>There is a typo in the batmand startup (init.d) script<br>the interface is refered as&nbsp; <br><br>interface=$(uci get batman.general.interface)<br>while it should be interface=$(uci get batmand.general.interface)<br>
(ie. batman should be batmand)<br><br>similar is the case with the options too.<br><br>the uci command arguments are <br>uci get/set packagename.config_profile.option<br><br>Regards,<br>Vinay<br>

------=_Part_9300_32872952.1201078167943--
