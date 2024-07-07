
# ask what the project name is 
read -p "Hello! What is your project named? " project_name
# ask to install framer motion
echo "Do you want to use frame-motion ? y/n"
read use_framermotion
#ask to install react-icons
echo "Do you want to use react-icons ? y/n"
read use_reacticons
# ask if color palette
echo "Do you have a color palette or a color ? y/n"
read use_color
echo "How much page will your project contain beside the Home page?"
read num_page


project="Project resume: name: $project_name , framer-motion: $use_framermotion ,  react-icons: $use_reacticons , color: $use_color "
echo $project

#create project
#navigate to folder
npx create-next-app@latest $project_name --js --eslint --tailwind --no-src-dir --app --import-alias "@/*"
cd $project_name

echo "installing dependencies"
#install dependencies
if [ "$use_framermotion" = "y" ]; then
    npm i framer-motion
fi
if [ "$use_reacticons" = "y" ]; then
    npm i react-icons
fi



# if num_page > loop to ask for the name of n page and create route in folder
if (( $num_page > 1)); then

    echo "Page route configurations:"
    pages=()

    for ((i=2; i<= num_page; i++)); do
        echo -n "Enter page $i name : "
        read page_name
        #append page name to pages string
        pages+=("$page_name")
    done

    echo "these pages will we be created: [ ${pages[@]} ] confirm ? y/n"
    read confirm_createpage

    
    #create all routes
    if [[ "$confirm_createpage" = "y" ]]; then
        cd app
<<<<<<< HEAD
        for page in "$pages[@]"; do 
=======
        for page in "${pages[@]}"; do 
>>>>>>> b64aba95f82b9ac8c1a3353dd3cbade72155b2d3
            mkdir -p "$page"
            echo "Created Route: $page"
        done
        echo "All routes have been created successfully"
    fi

fi

#if use tailwind add the color to tailwind config
if [ "$use_color" = "y" ]; then
    echo "Color configurations:"
   colors=""

    # Loop to ask user for 5 colors and their names
    for (( i=1; i<=5; i++ )); do
        # ask for color name
        echo -n "Enter color $i name: "
        read color_name

        # ask for color value
        echo -n "Enter color $i value (hex format, e.g., #ffffff): "
        read color_value

        # Append formatted color entry to the colors string
        colors="$colors
        $color_name: '$color_value',"
    done

    # Rm whitespace an comma
    colors=$(echo "$colors" | sed -e 's/^ *//' -e '/^$/d' -e '$ s/,$//')

    # final tailwindconfig file
     colors_config="
     /** @type {import('tailwindcss').Config} */
    module.exports = {
    content: [],
    theme: {
        extend: {
            colors : {
             $colors
            }
        },
    },
    plugins: [],
    }"

    # Update tailwind.config.js 
    rm tailwind.config.js
    echo "$colors_config" > "tailwind.config.js"
    echo "tailwind config file updated successfully"
fi

echo "project $project_name created successfully"
echo "do you want to open project ? y/n"
read open_project
if [ "$open_project" = "y" ]; then
    code .
fi


# todo
# ask for using existing local components and place it inside the projects
# ask "how much page the project will contain"
# create all the routes
# ask for if want to use specific fonts
# change the path 



