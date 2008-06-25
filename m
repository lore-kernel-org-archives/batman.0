From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] using routing script in addtion to batman routing
	rules
Date: Wed, 25 Jun 2008 18:09:47 +0800
References: <0e192879c584de17adb2dbfc872a5004.squirrel@wm.ddmesh.de>
In-Reply-To: <0e192879c584de17adb2dbfc872a5004.squirrel@wm.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806251809.47182.lindner_marek@yahoo.de>
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

> I have heard that you already have a similar functionality implemented in
> different batman branches. But this option will turn off setting the
> routes and rules of batmand.
>
> Can you please add/merge this functionality it to the exp-branch and
> perhaps add an option so that the normal route/rule setting is not turned
> off. The reason for this is that I like to detect the current gateway
> changes.

this "feature" is not missing. The routing script is by far more powerful than 
that. You can define your own rule prios / routing tables / event handlers / 
etc. Please have a look at the sample script to get the picture:
http://downloads.open-mesh.net/batman/useful-scripts-and-tools/policy_routing_script.sh

Greetings,
Marek
