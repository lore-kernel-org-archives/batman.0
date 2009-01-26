From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Jan 2009 11:08:21 +0100
References: <497CE6F6.7090504@francofon.fr>
	<200901260711.12511.lindner_marek@yahoo.de>
	<497D7F55.9040104@francofon.fr>
In-Reply-To: <497D7F55.9040104@francofon.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901261808.22139.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] problem with batman test
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


Hi,

> Adding route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)
> ^CDeleting route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)
> Error - can't delete route to 169.254.0.0/16 via 0.0.0.0 (table 254): No
> such process
> Deleting all BATMAN routes
> Interface deactivated: ath2
>
> The route isn't add when batmand is launch.

I just ran the same command as you and it works as expected. Why are you so 
sure that the route is not added ? Batman would throw an error message 
(similar to the delete error). But it does not happen. May be something else 
deletes the route ?
Could you check whether the command "logread" reveals more clues ?

Regards,
Marek

