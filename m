Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 16 Jul 2009 01:21:21 +0800
References: <dd8d36130907150659v74773aw1fd1060c43ab337b@mail.gmail.com>
In-Reply-To: <dd8d36130907150659v74773aw1fd1060c43ab337b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907160121.28937.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [vis] Remove duplicate routes from vis output
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

On Wednesday 15 July 2009 21:59:32 Edwe Cowley wrote:
> Revision 1271 introduced a bug on the call to hash->compare() that
> caused duplicate routes to appear in the output.  Inverted the
> conditional and now it works.

Thanks for informing us about this bug and proposing a solution. This is a bit 
tricky since batman and the vis server share the same hash implementation 
code. If we apply your patch we will move the bugs to batman. As you correctly 
pointed out the bug was introduced with 1271 because the vis hash->compare() 
callback function was not adapted. Please consider my following patch and let 
me know if it works for you.

Regards,
Marek

