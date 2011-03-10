Return-Path: <aep@it46.se>
Message-ID: <4D7883F8.7060303@it46.se>
Date: Thu, 10 Mar 2011 08:55:36 +0100
From: Alberto Escudero-Pascual <aep@it46.se>
MIME-Version: 1.0
References: <201103091748.32512.onelektra@gmx.net>
	<201103091804.55424.sven@narfation.org>
In-Reply-To: <201103091804.55424.sven@narfation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [Patch] vis: Modified format of JSON output.
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Sven,

Here you can get the two files

PATCHED VIS.C

http://dev.villagetelco.org/svn/villagetelco/server/trunk/src/install/vis/vis.c

and

http://dev.villagetelco.org/svn/villagetelco/server/trunk/src/install/vis/vis.c.patch

The patch was applied against the version

http://downloads.open-mesh.org/batman/releases/batman-0.3.2/vis-0.3.2.tar.gz


* The patch fixes three issues
 - Reporting of duplicated entries in the VIS output, this is fixed in
trunk but not in vis.0.3.2
 - Removed a gcc warning related to the use of chdir()
 - Cleaned up the JSON output of vis

Our code is in SVN so I have not git-send-email magic :)

-aep


On 03/09/2011 06:04 PM, Sven Eckelmann wrote:
> On Wednesday 09 March 2011 17:48:32 elektra wrote:
>> The current vis server JSON output format is breaking the json_decode()
>> function for PHP.
>>
>> This patch mainly:
>> - Removes all spaces
>> - Removes all the \t TABS
>> - Double quotes the string-variables
>>
>> Reported-by:  "Alberto Escudero-Pascual" <aep@it46.se>
>> Signed-off-by: "elektra" <onelektra@gmx.net>
> 
> I am not sure if anyone currently maintains batmand and vis.
> 
> Anyway, your patch is more or less scrambled. Can you please resend it using a 
> client which doesn't create a wordwrap and space massacre[1]. Many people here 
> seem to use git-send-email for that purpose.
> 
> Kind regards,
> 	Sven
> 
> [1] http://kernel.org/doc/Documentation/email-clients.txt
