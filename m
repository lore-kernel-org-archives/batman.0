Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 4 Sep 2013 14:48:07 +0800
References: <20130902070317.GF1871@ritirata.org>
 <1378212320-13946-1-git-send-email-marco.dallato@gmail.com>
In-Reply-To: <1378212320-13946-1-git-send-email-marco.dallato@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201309041448.07677.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batctl: add sys framework for VLAN
	support
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tuesday, September 03, 2013 20:45:20 Marco Dalla Torre wrote:
> +/**
> + * get_basedev_vid - given a valid VLAN interface, identifies the batman
> device + *	on top of which the VLAN is sitting and its VLAN ID
> + * @mesh_iface: name of the VLAN network interface
> + * @base_dev: output argument, pointer to the base device name
> + * @vid: output argument, pointer to the VLAN ID number
> + *
> + * Returns 0 if execution is successful, -1 if an error occurred
> + */
> +static int get_basedev_vid(const char *mesh_iface, char **base_dev,
> unsigned short *vid) +{
> +	char *vdev;
> +	char line[100];

Here we have a fixed buffer size.


> +	const char path[] = "/proc/net/vlan/";

Constants should be declared outside of a function as they could be re-used by 
other functions. If grouped together they are also easier to find.


> +	int size = strlen(path) + strlen(mesh_iface) + 1;
> +	FILE *fp = NULL;

Does not need to be initialized.


> +	char *fpath = malloc(size);
> +	/* prepare path file path: /proc/net/vlan/$mesh_iface*/
> +	snprintf(fpath, size, "%s%s", path, mesh_iface);

Here we have a dynamic path length without checking if malloc() failed.


> +	if (fscanf(fp, "%ms %*s %hu %*s %*d %*s %*d", &vdev, vid) == 0)
> +		return -1;

Shouldn't we check for "fscanf() != 2" ?


> +	while (fgets(line, sizeof(line), fp) != NULL) {
> +		if (sscanf(line, "Device: %ms", base_dev) == 1)
> +			break;
> +	}

How about using getline() instead of fgets() ? There are several examples 
throughout the batctl code.


> +	/* handle base device not found case */
> +	if (*base_dev == NULL)
> +		return -1;

It would be good style if we set *base_dev to NULL at the beginning of the 
function instead of relying on the caller to properly initialize the variable.


> +	if (access(path_buff, F_OK) != 0) {
> +		if (errno == ENOENT) {
> +			/* path does not exist, no lan interface: check vlan */
> +			unsigned short vid = 0;
> +			char *base_dev = NULL;

Please declare all variables at the beginning of the function.


> +			if (get_basedev_vid(mesh_iface, &base_dev, &vid) == 0) {
> +				free(path_buff);

Not sure why you need to free() here.


> +				char sys_vlan_path[] =
> +					"/sys/devices/virtual/net/%s/mesh/vlan%d/";

Yet another constant ..


> +				int size = sizeof(sys_vlan_path) + sizeof(base_dev);

Did you mean strlen() ?


> +				path_buff = malloc(size);

Malloc() can fail ...

Cheers,
Marek
